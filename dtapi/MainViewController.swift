//
//  MainViewController.swift
//  dtapi
//
//  Created by Volodymyr on 10/10/17.
//  Copyright © 2017 Volodymyr. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var specialities = SpecialityData.specialityData
    var refresh: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    @objc func refreshData(){
        self.refresh.beginRefreshing()
        getSpeciality(){ (speciality: [SpecialityModel.Speciality]) in
            SpecialityData.specialityData.specialityArray = speciality
        self.tableView.reloadData()
        }
        self.refresh.endRefreshing()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialities.specialityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpecialityTableViewCell
        let sArray = specialities.specialityArray[indexPath.row]
        cell.specialityIdLabel.text = sArray.speciality_id
        cell.specialityCodeLabel.text = sArray.speciality_code
        cell.specialityNameLabel.text = sArray.speciality_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit", handler: { action, indexPath in
            guard let createSpecialityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateSpecialityViewController") as? CreateSpecialityViewController else  { return }
            createSpecialityViewController.specialityInstance = self.specialities.specialityArray[indexPath.row]
            createSpecialityViewController.canEdit = true
            self.navigationController?.pushViewController(createSpecialityViewController, animated: true)
        })
        let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, indexPath in
            let alert = UIAlertController(title: "WARNING", message: "Do you want to delete this speciality?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                if indexPath.row < self.specialities.specialityArray.count {
                    deleteteSpeciality(id: self.specialities.specialityArray[indexPath.row].speciality_id, completionHandler: { (deleted) in
                        if deleted {
                            self.specialities.specialityArray.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .top)
                            self.tableView.reloadData()
                        }
                    })
                }
            }))
            alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        })
        return [edit, delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    @IBAction func createNewSpeciality(_ sender: Any) {
        guard let createSpecialityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateSpecialityViewController") as? CreateSpecialityViewController else  { return }
        self.navigationController?.pushViewController(createSpecialityViewController, animated: true)
    }
    
}


