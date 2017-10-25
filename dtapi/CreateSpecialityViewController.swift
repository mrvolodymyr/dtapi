//
//  CreateSpecialityViewController.swift
//  dtapi
//
//  Created by ITA student on 10/19/17.
//  Copyright © 2017 Volodymyr. All rights reserved.
//

import UIKit

class CreateSpecialityViewController: UIViewController {
    
    @IBOutlet weak var specialityCodeTextField: UITextField!
    @IBOutlet weak var specialityNameTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    var speciality = SpecialityData.specialityData
    var specialityInstance: SpecialityModel.Speciality? {
        didSet {
            self.view.layoutIfNeeded()
            self.title = "Editing"
            specialityNameTextField.text = specialityInstance?.speciality_name
            specialityCodeTextField.text = specialityInstance?.speciality_code
            createButton.titleLabel?.text = "Save"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func CreateSpecialityButton(_ sender: Any) {
        HTTPService().createSpeciality(specialityCode: specialityCodeTextField.text!, specialityName: specialityNameTextField.text!)
        self.navigationController?.popViewController(animated: true)
    }
        

}
