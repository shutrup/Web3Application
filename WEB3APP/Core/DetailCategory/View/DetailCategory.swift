//
//  DetailCategory.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 21.05.2023.
//

import SwiftUI

struct DetailCategory: View {
    @StateObject private var vm = DetailViewModel()
    @EnvironmentObject private var categoryVM: CategoryViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .accenttColor.opacity(0.4)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack {
                Text(categoryVM.currentExercise?.title ?? "LOX")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                HStack(alignment: .bottom, spacing: 0) {
                    Text("За выполнение данного упражнение дается  \(categoryVM.currentExercise?.point ?? 0)")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                    
                    Image("primary")
                        .resizable()
                        .frame(width: 15, height: 20)
                        .foregroundColor(.accenttColor)
                        .padding(.bottom, 3)
                }
                
                GeometryReader { proxy in
                    VStack(spacing: 15) {
                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.03))
                                .padding(-40)
                            
                            Circle()
                                .trim(from: 0, to: vm.progress)
                                .stroke(.white.opacity(0.03), lineWidth: 80)
                            
                            Circle()
                                .stroke(Color.accenttColor.opacity(0.3), lineWidth: 10)
                                .blur(radius: 15)
                                .padding(-2)
                            
                            Circle()
                                .fill(Color.black.opacity(0.1))
                            
                            
                            Circle()
                                .trim(from: 0, to: vm.progress)
                                .stroke(Color.accenttColor, lineWidth: 10)
                            
                            GeometryReader { proxy in
                                let size = proxy.size
                                
                                Circle()
                                    .fill(Color.accenttColor)
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .overlay(content: {
                                         Circle()
                                            .fill(.white)
                                            .padding(5)
                                    })
                                    .frame(width: size.width, height: size.height , alignment: .center)
                                    .offset(x: size.width / 2)
                                    .rotationEffect(.init(degrees: vm.progress * 360))
                            }
                            
                            Text(vm.timerStringValue)
                                .font(.system(size: 45, weight: .light))
                                .rotationEffect(.init(degrees: 90))
                                .animation(.none, value: vm.progress)
                        }
                        .padding(60)
                        .frame(width: proxy.size.width)
                        .rotationEffect(.init(degrees: -90))
                        .animation(.easeInOut, value: vm.progress)
                        
                        Button {
                            if vm.isStarted {
                                vm.stopTimer()
                            } else {
                                vm.startTimer()
                            }
                        } label: {
                            Image(systemName: !vm.isStarted ? "timer" : "pause")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80)
                                .background {
                                    Circle()
                                        .fill(Color.accenttColor)
                                }
                                .shadow(color: Color.accenttColor, radius: 8, x: 0, y: 0)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            .padding()
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect() ) { _ in
                if vm.isStarted {
                    vm.updateTimer()
                }
            }
            .alert("Поздравляю вы успешно закончили упражнение", isPresented: $vm.isFinished) {
                Button(role: .cancel) {
                    vm.stopTimer()
                    vm.startTimer()
                } label: {
                    Text("Повторить")
                }
                
                Button(role: .destructive) {
                    vm.stopTimer()
                    categoryVM.currentExercise = nil
                    Task {
                        await categoryVM.exerciseUser(user: "0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8", exercise: categoryVM.currentExercise?.id ?? 0)
                    }
                } label: {
                    Text("Закрыть")
                }
            }
            .onAppear {
                vm.seconds = categoryVM.currentExercise?.secondsTime ?? 0
            }
        }
    }
}

struct DetailCategory_Previews: PreviewProvider {
    static var previews: some View {
        DetailCategory()
            .environmentObject(CategoryViewModel(exerciseService: ExerciseService()))
    }
}

