//
//  DaysEndpoint.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 21.05.2023.
//

import Foundation

enum DaysEndpoint: Endpoint {
    case getDays
    case getDaysList
    case countMouth
    
    var path: String {
        switch self {
        case .getDays:
            return API.apiDays
        case.getDaysList:
            return API.apiDaysList
        case .countMouth:
            return API.countMouth
        }
    }
    
    var method: RequestMethod {
        switch self {
        case.getDays, .getDaysList, .countMouth:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getDays, .getDaysList, .countMouth:
            return nil
        }
    }
    
    var header: [String : String]? {
        return nil
    }
}
