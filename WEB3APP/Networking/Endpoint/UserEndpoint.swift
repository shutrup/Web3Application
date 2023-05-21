//
//  UserEndpoint.swift
//  WEB3APP
//
//  Created by timur on 21.05.2023.
//

import Foundation

enum UserEndpoint: Endpoint {
    case createUser(id: String, full_name: String)
    case getUserInfo
    
    var path: String {
        switch self {
        case .createUser:
            return API.createUser
        case.getUserInfo:
            return API.getUserInfo
        }
    }
    
    var method: RequestMethod {
        switch self {
        case.createUser:
            return .post
        case.getUserInfo:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .createUser(let id, let full_name):
            return ["id": id, "first_name": full_name]
        case.getUserInfo:
            return nil
        }
    }
    
    var header: [String : String]? {
        return nil
    }
}
