//
//  Result.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 8, 2021

import Foundation
import CoreData


//MARK: ReultObject Codable Struct Model

struct Result : Codable,DefaultsSerializable {
    
    var address : String?
    var age : String?
    var birthday : String?
    var contactperson : String?
    var cpmobileno : String?
    var email : String?
    var firstname : String?
    var id : Int?
    var lastname : String?
    var mobileno : String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case age = "age"
        case birthday = "birthday"
        case contactperson = "contactperson"
        case cpmobileno = "cpmobileno"
        case email = "email"
        case firstname = "firstname"
        case id = "id"
        case lastname = "lastname"
        case mobileno = "mobileno"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        birthday = try values.decodeIfPresent(String.self, forKey: .birthday)
        contactperson = try values.decodeIfPresent(String.self, forKey: .contactperson)
        cpmobileno = try values.decodeIfPresent(String.self, forKey: .cpmobileno)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        firstname = try values.decodeIfPresent(String.self, forKey: .firstname)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        mobileno = try values.decodeIfPresent(String.self, forKey: .mobileno)
    }
    
    
}
