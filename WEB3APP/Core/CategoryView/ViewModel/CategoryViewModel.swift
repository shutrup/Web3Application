//
//  CategoryViewModel.swift
//  WEB3APP
//
//  Created by timur on 21.05.2023.
//

import SwiftUI

final class CategoryViewModel: ObservableObject {
    
    let exerciseService: ExerciseServiceProtocol
    
    init(exerciseService: ExerciseServiceProtocol) {
        self.exerciseService = exerciseService
    }
    
    @Published var exercises: [Results] = []
    @Published var currentExercise: Results? = nil {
        didSet {
            if currentExercise != nil {
                withAnimation {
                    showDetailView = true
                }
            }
        }
    }
    @Published var showDetailView: Bool = false
    
    @MainActor func getExercises() async {
        let result = await exerciseService.getExercises()
        switch result {
        case .success(let success):
            self.exercises = success.results
        case .failure(let failure):
            print(failure.message)
        }
    }
    
    @MainActor func getExercise(id: Int) async {
        let result = await exerciseService.getExercise(id: id)
        switch result {
        case .success(let success):
            currentExercise = success
        case .failure(let failure):
            print(failure.message)
        }
    }
    
    @MainActor func exerciseUser(user: String, exercise: Int) async {
        let result = await exerciseService.exercise(user: user, exercise: exercise)
        switch result {
        case .success(let success):
            print(success.exercise)
        case .failure(let failure):
            print(failure.message)
        }
    }
}
