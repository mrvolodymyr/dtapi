//
//  SpecialityStucture.swift
//  dtapi
//
//  Created by Volodymyr on 10/17/17.
//  Copyright © 2017 Volodymyr. All rights reserved.
//

import Foundation

class SpecialityModel: NSObject {

    struct Speciality: Decodable {
        var speciality_code: String
        var speciality_id: String
        var speciality_name: String
        
        init?(json: [String: Any]) {
            guard let speciality_code = json["speciality_code"] as? String,
                let speciality_id = json["speciality_id"] as? String,
                let speciality_name = json["speciality_name"] as? String else {
                    return nil
            }
            self.speciality_code = speciality_code
            self.speciality_id = speciality_id
            self.speciality_name = speciality_name
        }
    }

    struct NewSpeciality {
        let specialityCode: String
        let specialityName: String
        
        var createJSON: [String:String]{
            return [
                "speciality_code": specialityCode,
                "speciality_name": specialityName
            ]
        }
    }
}
