//
//  UserModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 8, 2021

import Foundation


//MARK: MainObject Codable Struct Model

struct UserModel : Codable {

        let result : [Result]?

        enum CodingKeys: String, CodingKey {
                case result = "result"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                result = try values.decodeIfPresent([Result].self, forKey: .result)
        }

}
