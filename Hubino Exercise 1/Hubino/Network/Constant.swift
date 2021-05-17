//
//  Constant.swift
//  Hubino
//
//  Created by wmdev-sep on 08/05/21.
//

import Foundation

//MARK: REST API Http Method Constant
enum HttpMethod {
    case Post
    case Get
}

//MARK: REST API Request URL Constant
struct HttpUrl {
    static let getUserList = "https://us-central1-fwd-api.cloudfunctions.net/getUsersList"
}
