//
//  API.swift
//  DGUNH
//
//  Created by timur on 17.05.2023.
//

import Foundation

struct API {
    static var baseUrl = "http://195.135.255.26"
    
    static var apiDays = "/api/0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8/days"
    static var apiDaysList = "/api/0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8/days/list"
    
    static var createUser = "/api/user/"
    static var getUserInfo = "/api/user/0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8/"
    
    static var exercises = "/api/exercise/"
    static var exercise = "/api/exercise/"
    
    static var exerciseUser = "/api/exercise-user/"
    
    static var countMouth = "/api/0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8/count_mouth"
}

