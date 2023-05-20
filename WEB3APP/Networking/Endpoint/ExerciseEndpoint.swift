//
//  ExerciseEndpoint.swift
//  WEB3APP
//
//  Created by timur on 21.05.2023.
//

import Foundation

enum ExerciseEndpoint: Endpoint {
    case getExercises
    case getExercise(id: Int)
    
    var path: String {
        switch self {
        case.getExercises:
            return API.exercises
        case.getExercise(let id):
            return API.exercise+"\(id)/"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case.getExercise:
            return .get
        case .getExercises:
            return.get
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var header: [String : String]? {
        return nil
    }
}
