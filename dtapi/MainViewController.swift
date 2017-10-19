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
        HTTPService().getSpeciality(){ (speciality: [Speciality]) in
            self.specialityArray = speciality
            DispatchQueue.main.async {
                self.tableViewController.reloadData()
            }
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
    
    @IBAction func buttonTapped(_ sender: Any) {
        if specialityArray.count < 0 {
            print(specialityArray[0])
        } else {
            print("array is empty")
        }
    }
}
