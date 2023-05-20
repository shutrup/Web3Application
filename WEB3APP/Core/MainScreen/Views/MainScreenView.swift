//
//  MainScreenView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct MainScreenView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .accenttColor.opacity(0.3)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Привет, ")
                        
                        Text("Бага")
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
                    Circle()
                        .frame(width: 230, height: 230)
                        .foregroundColor(.accenttColor)
                        .blur(radius: 20)
                    
                    VStack(spacing: 18) {
                        Image("primary")
                            .resizable()
                            .frame(width: 40, height: 44)
                            .foregroundColor(.white)
                            .shadow(color: Color.white.opacity(0.82), radius: 13, x: 0, y: 0)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("15 /")
                                
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
                    .zIndex(1)
                }
                .padding(.top, 54)
                
                VStack(spacing: 7) {
                    HStack {
                        Text("500")
                            .font(.system(size: 27))
                            .fontWeight(.bold)
                        
                        Text("TOGO")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .padding(.top, 5)
                        
                        Spacer()
                        
                        Text("1500")
                            .font(.system(size: 27))
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    ProgressView(value: 3, total: 10)
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
                        ForEach(1..<30) { int in
                            CalendarCellView(day: int)
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

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
