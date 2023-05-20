//
//  ExerciseViewModel.swift
//  WEB3APP
//
//  Created by timur on 21.05.2023.
//

import Foundation

final class ExerciseViewModel: ObservableObject {
    
    let exerciseService: ExerciseServiceProtocol
    
    init(exerciseService: ExerciseServiceProtocol) {
        self.exerciseService = exerciseService
        Task {
            await getExercises()
            await getExercise(id: 3)
        }
    }
    
    @MainActor func getExercises() async {
        let result = await exerciseService.getExercises()
        switch result {
        case .success(let success):
            print(success)
        case .failure(let failure):
            print(failure.message)
        }
    }
    
    @MainActor func getExercise(id: Int) async {
        let result = await exerciseService.getExercise(id: id)
        switch result {
        case .success(let success):
            print(success)
        case .failure(let failure):
            print(failure.message)
        }
    }
}
