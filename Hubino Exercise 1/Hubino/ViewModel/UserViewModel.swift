//
//  UserViewModel.swift
//  Hubino
//
//  Created by wmdev-sep on 08/05/21.
//

import Foundation
import UIKit

protocol MovieViewModelProtocol {
    
    var getUserList: ((Bool) -> Void)? { get set }
}
class UserViewModel: MovieViewModelProtocol {

    //MARK: - Internal Properties
    
    var getUserList: ((Bool) -> Void)?
    
    var userList: [Result]? {
        didSet {
            guard let getList = getUserList else {return}
            getList(true)
        }
    }
    
    func fetchUserList() {
        
        self.userList = [Result]()
        
        APIManager.shared.getUserDataFromServer { (userData) in
            self.userList = userData?.result
         //   Defaults[\.userResult] = userData?.result
        } onFailure: { (error) in
                print("\(error)")
        }
    }
    
}
