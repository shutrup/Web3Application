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
    case exercises(user: String, exercise: Int)
    
    var path: String {
        switch self {
        case.getExercises:
            return API.exercises
        case.getExercise(let id):
            return API.exercise+"\(id)/"
        case.exercises:
            return API.exerciseUser
        }
    }
    
    var method: RequestMethod {
        switch self {
        case.getExercise:
            return .get
        case .getExercises:
            return.get
        case.exercises:
            return.post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getExercises:
            return [:]
        case .getExercise:
            return [:]
        case .exercises(let user, let exercise):
            return ["user": user,
                    "exercise": exercise]
        }
    }
    
    var header: [String : String]? {
        return nil
    }
}
