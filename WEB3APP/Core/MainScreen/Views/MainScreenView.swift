//
//  MainScreenView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct MainScreenView: View {
    @State var dragOffset: CGSize = .zero
    
    var body: some View {
        VStack {
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
    }
}

struct MyCustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.52394*width, y: 0.00005*height))
        path.addCurve(to: CGPoint(x: 0.87486*width, y: 0.24246*height), control1: CGPoint(x: 0.6775*width, y: 0.00289*height), control2: CGPoint(x: 0.78461*width, y: 0.12749*height))
        path.addCurve(to: CGPoint(x: 0.9957*width, y: 0.60101*height), control1: CGPoint(x: 0.95852*width, y: 0.34903*height), control2: CGPoint(x: 1.01666*width, y: 0.47073*height))
        path.addCurve(to: CGPoint(x: 0.76017*width, y: 0.95524*height), control1: CGPoint(x: 0.97249*width, y: 0.74527*height), control2: CGPoint(x: 0.89979*width, y: 0.88752*height))
        path.addCurve(to: CGPoint(x: 0.29528*width, y: 0.94072*height), control1: CGPoint(x: 0.61569*width, y: 1.02532*height), control2: CGPoint(x: 0.44159*width, y: 1.00747*height))
        path.addCurve(to: CGPoint(x: 0.00542*width, y: 0.61088*height), control1: CGPoint(x: 0.15076*width, y: 0.87478*height), control2: CGPoint(x: 0.03434*width, y: 0.75755*height))
        path.addCurve(to: CGPoint(x: 0.15499*width, y: 0.22915*height), control1: CGPoint(x: -0.02219*width, y: 0.4708*height), control2: CGPoint(x: 0.05992*width, y: 0.34114*height))
        path.addCurve(to: CGPoint(x: 0.52394*width, y: 0.00005*height), control1: CGPoint(x: 0.25124*width, y: 0.11576*height), control2: CGPoint(x: 0.36815*width, y: -0.00283*height))
        path.closeSubpath()
        return path
    }
}

