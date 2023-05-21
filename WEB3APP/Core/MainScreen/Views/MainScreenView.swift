//
//  MainScreenView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @State var dragOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.black, .accenttColor.opacity(0.3)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Привет, ")
                            
                            Text(homeVM.userName)
                                .foregroundColor(Color.accenttColor)
                        }
                        .font(.system(size: 27))
                        .fontWeight(.bold)
                        
                        Text("Готов к занятиям?")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .opacity(0.86)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    ZStack {
                        ClubbedView()
                            .frame(width: 230, height: 230)
                            .blur(radius: 10)
                            .zIndex(1)
                        
                        VStack(spacing: 18) {
                            Image("primary")
                                .resizable()
                                .frame(width: 35, height: 44)
                                .foregroundColor(.white)
                                .shadow(color: Color.white.opacity(0.82), radius: 13, x: 0, y: 0)
                            
                            VStack(spacing: 12) {
                                HStack {
                                    Text("\(homeVM.tokcenCount.first?.totalPoints ?? 0) /")
                                    
                                    Text("30")
                                }
                                .fontWeight(.bold)
                                .font(.system(size: 27))
                                
                                Text("Осталось 15 очков!")
                                    .opacity(0.86)
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                            }
                        }
                        .zIndex(2)
                    }
                    .padding(.top, 54)
                    
                    VStack(spacing: 7) {
                        HStack {
                            Text("0")
                                .font(.system(size: 27))
                                .fontWeight(.bold)
                            
                            Text("TOGO")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .padding(.top, 5)
                            
                            Spacer()
                            
                            Text("50")
                                .font(.system(size: 27))
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                        
                        ProgressView(value: 10, total: 50)
                            .tint(.accenttColor)
                            .frame(height: 5)
                            .cornerRadius(10)
                            .scaleEffect(x: 1, y: 3.5, anchor: .center)
                            .padding(.horizontal, 16)
                        
                        Text("Путь к бесплатному абонементу")
                            .font(.system(size: 15))
                            .bold()
                            .opacity(0.86)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 5)
                    }
                    .padding(.top, 28)
                    
                    VStack(alignment: .leading){
                        Text("Календарь")
                            .font(.system(size: 27))
                            .fontWeight(.bold)
                        
                        Text("Май, 2023")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .opacity(0.86)
                            .foregroundColor(.accenttColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 35)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(homeVM.calendar, id: \.self) { day in
                                CalendarCellView(calendar: day)
                                    .padding(2)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder func ClubbedView() -> some View {
        TimelineView(.animation(minimumInterval: 3.6, paused: false)) { _ in
            Canvas { context, size in
                context.addFilter(.alphaThreshold(min: 0.5, color: .accenttColor))
                context.addFilter(.blur(radius: 30))
                                  
                context.drawLayer { ctx in
                    for index in 1...15 {
                        if let resolvedView = context.resolveSymbol(id: index) {
                            ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                        }
                    }
                }
            } symbols: {
                ForEach(1...15, id: \.self) { i in
                    let offset = CGSize(width: .random(in: -60...60), height: .random(in: -60...60))

                    ClubbedRoundedRectangle(offset: offset)
                        .tag(i)
                }
            }
        }
    }
    
    @ViewBuilder func ClubbedRoundedRectangle(offset: CGSize = .zero) -> some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .frame(width: 120, height: 120)
            .offset(offset)
            .animation(.easeInOut(duration: 4), value: offset)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(HomeViewModel(userService: UserService(), daysService: DaysService()))
    }
}
