//
//  Service.swift
//  WEB3APP
//
//  Created by timur on 21.05.2023.
//

import Foundation

protocol UserServiceProtocol {
    func createUser(id: String, fullName: String) async -> Result<User, RequestError>
    func getUserInfo() async -> Result<User, RequestError>
}

class UserService: BaseRequest, UserServiceProtocol {
    func createUser(id: String, fullName: String) async -> Result<User, RequestError> {
        return await sendRequest(endpoint: UserEndpoint.createUser(id: id, full_name: fullName), responseModel: User.self)
    }
    
    func getUserInfo() async -> Result<User, RequestError> {
        return await sendRequest(endpoint: UserEndpoint.getUserInfo, responseModel: User.self)
    }
}
