//
//  HTTPService.swift
//  dtapi
//
//  Created by Volodymyr on 10/19/17.
//  Copyright © 2017 Volodymyr. All rights reserved.
//

import Foundation

class  HTTPService{
    
    func logIn(completionHandler: @escaping (_ isLog: Bool) -> ()) {
        let requestBody = ["username": "admin", "password": "dtapi_admin"]
        guard let url = URL(string: "http://vps9615.hyperhost.name/login/index") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("UTF-8", forHTTPHeaderField: "Charset")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                DispatchQueue.main.sync {
                    completionHandler(true)
                }
            }
            catch{
                print(error)
            }
        }.resume()
    }
    
    func getSpeciality(completionHandler: @escaping (_ speciality: [SpecialityModel.Speciality]) -> ()) {
        guard let url = URL(string: "http://vps9615.hyperhost.name/Speciality/getRecords") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("utf-8", forHTTPHeaderField: "Charset")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode([SpecialityModel.Speciality].self, from: data)
                DispatchQueue.main.sync {
                    completionHandler(json)
                }
            }
            catch{
                print("error")
            }
        }.resume()
        
    }
    
    func createSpeciality(specialityCode: String, specialityName: String) {
        guard let url = URL(string: "http://vps9615.hyperhost.name/Speciality/InsertData") else { return }
        
        let sendSpeciality = SpecialityModel.NewSpeciality(specialityCode: specialityCode, specialityName: specialityName)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: sendSpeciality.createJSON, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse, let data = data{
                    if response.statusCode == 200 {
                        print(response, data)
                    } else {
                        print("status code: ", response.statusCode )
                    }
                }
            }
        }.resume()
        
    }
    
    func deleteteSpeciality(id: String, completionHandler: @escaping (_ deleted: Bool) -> ()) {
        guard let url = URL(string: "http://vps9615.hyperhost.name/Speciality/del/" + id) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse, let data = data{
                    if response.statusCode == 200 {
                        print(response, data)
                        DispatchQueue.main.sync {
                            completionHandler(true)
                        }
                    } else {
                        print("status code: ", response.statusCode )
                    }
                    DispatchQueue.main.sync {
                        completionHandler(false)
                    }
                }
            }
        }.resume()
    }
    
}
