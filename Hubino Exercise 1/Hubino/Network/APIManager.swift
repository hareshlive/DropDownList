//
//  APIManager.swift
//  Hubino
//
//  Created by wmdev-sep on 08/05/21.
//

import Foundation
import Alamofire

import UIKit

//MARK: Network API Manager For Fetch User Result Data
class APIManager: NSObject {

    static let shared = APIManager()
    
    func getUserDataFromServer(onSuccess:@escaping(UserModel?) -> Void,onFailure:@escaping(_ error:Error) -> Void) {
        AF.request(HttpUrl.getUserList, parameters: nil, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                    do {
                        let userData = try JSONDecoder().decode(UserModel.self, from: jsonData ?? Data())
                        onSuccess(userData)
                    } catch {
                        
                    }
                }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
