//
//  ExerciseServise.swift
//  WEB3APP
//
//  Created by timur on 21.05.2023.
//

import Foundation

protocol ExerciseServiceProtocol {
    func getExercises() async -> Result<Exercise, RequestError>
    func getExercise(id: Int) async -> Result<Results, RequestError>
    func exercise(user: String, exercise: Int) async -> Result<ExerciseResponse, RequestError>
}

class ExerciseService: BaseRequest, ExerciseServiceProtocol {
    func getExercise(id: Int) async -> Result<Results, RequestError> {
        return await sendRequest(endpoint: ExerciseEndpoint.getExercise(id: id), responseModel: Results.self)
    }

    func getExercises() async -> Result<Exercise, RequestError> {
        return await sendRequest(endpoint: ExerciseEndpoint.getExercises, responseModel: Exercise.self)
    }
    
    func exercise(user: String, exercise: Int) async -> Result<ExerciseResponse, RequestError> {
        return await sendRequest(endpoint: ExerciseEndpoint.exercises(user: user, exercise: exercise), responseModel: ExerciseResponse.self)
    }
}

struct ExerciseResponse: Codable {
    let user: String
    let exercise: Int
}
