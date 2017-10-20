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
    var specialityArray = SpecialityData.specialityData.specialityArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HTTPService().getSpeciality(){ (speciality: [SpecialityModel.Speciality]) in
            self.specialityArray = speciality
            self.tableViewController.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpecialityTableViewCell
        let sArray = self.specialityArray[indexPath.row]
        cell.specialityIdLabel.text = sArray.speciality_id
        cell.specialityCodeLabel.text = sArray.speciality_code
        cell.specialityNameLabel.text = sArray.speciality_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < self.specialityArray.count {
            HTTPService().deleteteSpeciality(id: specialityArray[indexPath.row].speciality_id, completionHandler: { (deleted) in
                if deleted {
                    self.specialityArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .top)
                    self.tableViewController.reloadData()
                }
            })
            
        }
    }

    
    @IBAction func createNewSpeciality(_ sender: Any) {
        guard let createSpecialityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateSpecialityViewController") as? CreateSpecialityViewController else  { return }
        self.navigationController?.pushViewController(createSpecialityViewController, animated: true)
    }

}
    


