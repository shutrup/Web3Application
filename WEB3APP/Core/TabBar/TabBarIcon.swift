//
//  TabBarIcon.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct TabBarIcon: View {
    var tab: Tab
    @Binding var currentTab: Tab
    
    var body: some View {
        VStack {
            Image(tab.icon)
                .resizable()
                .frame(width: currentTab == tab ? 70: 60, height: currentTab == tab ? 70: 60)
        }
        .scaleEffect(0.4)
        .background(currentTab == tab ? Color.accentColor : .clear)
        .cornerRadius(58)
        .padding(.bottom, currentTab == tab ? 5: 0 )
        .onTapGesture {
            withAnimation {
                currentTab = tab
            }
        }
    }
}

struct TabBarIcon_Previews: PreviewProvider {
    static var previews: some View {
        TabBarIcon(tab: .home, currentTab: .constant(.home))
    }
}
