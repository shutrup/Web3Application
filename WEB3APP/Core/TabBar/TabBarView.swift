//
//  TabBarView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var store: Store
    @StateObject var homeVM = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                tabBarView
                tabBarIcon
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(Store())
    }
}


extension TabBarView {
    private var tabBarView: some View {
        TabView (selection: $store.currenTab){
            HomeView()
                .environmentObject(homeVM)
                .tag(Tab.profile)
                .navigationBarHidden(true)
            MainScreenView()
                .tag(Tab.home)
                .navigationBarHidden(true)
            Text("Lox")
                .tag(Tab.category)
                .navigationBarHidden(true)
        }
        .onAppear {
            UITabBar.appearance().barTintColor = .white
        }
    }
    private var tabBarIcon: some View {
        HStack(alignment: .center, spacing: 50) {
            ForEach(Tab.allCases, id: \.self) { tab in
                TabBarIcon(tab: tab, currentTab: $store.currenTab)
            }
            .padding(.bottom, 54)
            .padding(.top, 10)
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(y: 40)
    }
}
