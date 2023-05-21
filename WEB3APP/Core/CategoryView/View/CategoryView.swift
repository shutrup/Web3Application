//
//  CategoryView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var vm = CategoryViewModel(exerciseService: ExerciseService())
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .accenttColor.opacity(0.4)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 35) {
                    ForEach(vm.exercises, id: \.self) { exercises in
                        ZStack {
                            CategoryCellView(title: exercises.title, minute: exercises.secondsTime, point: exercises.point, imageUrl: exercises.photos.the1)
                                .onTapGesture {
                                    Task {
                                        await vm.getExercise(id: exercises.id)
                                    }
                            }
                            
                            NavigationLink(isActive: $vm.showDetailView) {
                                DetailCategory()
                                    .environmentObject(vm)
                            } label: {
                                EmptyView()
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await vm.getExercises()
                }
        }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
