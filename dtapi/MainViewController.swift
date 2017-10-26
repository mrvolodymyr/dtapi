//
//  MainViewController.swift
//  dtapi
//
//  Created by Volodymyr on 10/10/17.
//  Copyright © 2017 Volodymyr. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableViewController: UITableView!
    
    var specialities = SpecialityData.specialityData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HTTPService().getSpeciality(){ (speciality: [SpecialityModel.Speciality]) in
            SpecialityData.specialityData.specialityArray = speciality
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableViewController.reloadData()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < specialities.specialityArray.count {
            HTTPService().deleteteSpeciality(id: specialities.specialityArray[indexPath.row].speciality_id, completionHandler: { (deleted) in
                if deleted {
                    self.specialities.specialityArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .top)
                    self.tableViewController.reloadData()
                }
            })
            
        }
    }
    
    // editing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let createSpecialityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateSpecialityViewController") as? CreateSpecialityViewController else  { return }
        createSpecialityViewController.specialityInstance = specialities.specialityArray[indexPath.row]
        self.navigationController?.pushViewController(createSpecialityViewController, animated: true)
    }
    
    @IBAction func createNewSpeciality(_ sender: Any) {
        guard let createSpecialityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateSpecialityViewController") as? CreateSpecialityViewController else  { return }
        self.navigationController?.pushViewController(createSpecialityViewController, animated: true)
    }
    
}


