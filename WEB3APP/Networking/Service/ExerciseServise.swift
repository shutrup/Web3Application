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
}

class ExerciseService: BaseRequest, ExerciseServiceProtocol {
    func getExercise(id: Int) async -> Result<Results, RequestError> {
        return await sendRequest(endpoint: ExerciseEndpoint.getExercise(id: id), responseModel: Results.self)
    }

    func getExercises() async -> Result<Exercise, RequestError> {
        return await sendRequest(endpoint: ExerciseEndpoint.getExercises, responseModel: Exercise.self)
    }
}
