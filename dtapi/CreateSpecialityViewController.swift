//
//  CreateSpecialityViewController.swift
//  dtapi
//
//  Created by ITA student on 10/19/17.
//  Copyright © 2017 Volodymyr. All rights reserved.
//

import UIKit

class CreateSpecialityViewController: UIViewController {
    
    @IBOutlet weak var specialytyCodeTaxtField: UITextField!
    @IBOutlet weak var specialityNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func CreateSpecialityButton(_ sender: Any) {
        let specialityCodeText = specialytyCodeTaxtField.text!
        let specialityNameText  = specialityNameTextField.text!
        
        HTTPService().createSpeciality(specialityCode: specialityCodeText, specialityName: specialityNameText)
        self.navigationController?.popViewController(animated: true)
    }
    
}
