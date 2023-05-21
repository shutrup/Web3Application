//
//  API.swift
//  DGUNH
//
//  Created by timur on 17.05.2023.
//

import Foundation

struct API {
    static var baseUrl = "http://195.135.255.26"
    
    static var apiDays = "/api/\(Constants.userID)/days"
    static var apiDaysList = "/api/\(Constants.userID)/days/list"
    
    static var createUser = "/api/user/"
    static var getUserInfo = "/api/user/\(Constants.userID)/"
    
    static var exercises = "/api/exercise/"
    static var exercise = "/api/exercise/"
    
    static var countMouth = "/api/\(Constants.userID)/count_mouth"
}

