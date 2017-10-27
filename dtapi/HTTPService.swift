//
//  HTTPService.swift
//  dtapi
//
//  Created by Volodymyr on 10/19/17.
//  Copyright © 2017 Volodymyr. All rights reserved.
//

import Foundation

enum Link: String {
    case protocols = "http://"
    case base = "vps9615.hyperhost.name"
    case login = "/login/index"
    case entity = "/Speciality"
    case getRecords = "/getRecords"
    case insertData = "/InsertData"
    case delete = "/del"
    case update = "/update"
}
    
func logIn(completionHandler: @escaping (_ isLog: Bool) -> ()) {
    let requestBody = ["username": "admin", "password": "dtapi_admin"]
    guard let url = URL(string: Link.protocols.rawValue + Link.base.rawValue + Link.login.rawValue) else { return }
    
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
            print("Error: \(error.localizedDescription)")
        }
        }.resume()
}

func getSpeciality(completionHandler: @escaping (_ speciality: [SpecialityModel.Speciality]) -> ()) {
    guard let url = URL(string: Link.protocols.rawValue + Link.base.rawValue + Link.entity.rawValue + Link.getRecords.rawValue) else { return }
    
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
            print("Error: \(error.localizedDescription)")
        }
        }.resume()
    
}

func createSpeciality(specialityCode: String, specialityName: String) {
    guard let url = URL(string: Link.protocols.rawValue + Link.base.rawValue + Link.entity.rawValue + Link.insertData.rawValue) else { return }
    
    let sendSpeciality = SpecialityModel.NewSpeciality(specialityCode: specialityCode, specialityName: specialityName)
    guard let httpBody = try? JSONSerialization.data(withJSONObject: sendSpeciality.createJSON, options: []) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = httpBody
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
        } else {
            if let response = response as? HTTPURLResponse, let data = data {
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
    guard let url = URL(string: Link.protocols.rawValue + Link.base.rawValue + Link.entity.rawValue + Link.delete.rawValue + "/" + id) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
        } else {
            if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    print(response, data)
                    DispatchQueue.main.sync {
                        completionHandler(true)
                    }
                } else {
                    print("status code: \(response.statusCode)" )
                }
                DispatchQueue.main.sync {
                    completionHandler(false)
                }
            }
        }
        }.resume()
}

func editSpeciality(id: String, completionHandler: @escaping (_ deleted: Bool) -> ()) {
    guard let url = URL(string: Link.protocols.rawValue + Link.base.rawValue + Link.entity.rawValue + Link.update.rawValue + "/" + id) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
        } else {
            if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    print(response, data)
                    DispatchQueue.main.sync {
                        completionHandler(true)
                    }
                } else {
                    print("status code: \(response.statusCode)" )
                }
                DispatchQueue.main.sync {
                    completionHandler(false)
                }
            }
        }
        }.resume()
}

