//
//  ViewController.swift
//  dtapi
//
//  Created by Volodymyr on 10/10/17.
//  Copyright © 2017 Volodymyr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let login = loginText.text!
//        let password = passwordText.text!
//        
//        guard let url = URL(string: "http://vps9615.hyperhost.name") else { return }
//        
//        let session = URLSession.shared
//        session.dataTask(with: url){ (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            if let date = data {
//                print(data)
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                }
//                catch{
//                    print(error)
//                }
//            }
//            
//            }.resume()
//        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let requestBody = ["username": "admin", "password": "dtapi_admin"]
        
        guard let url = URL(string: "http://vps9615.hyperhost.name") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    
    }
    
    
//    guard let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else  {
    //        return
    //        }
    //        navigationController?.pushViewController(mainVC, animated: true)

}
