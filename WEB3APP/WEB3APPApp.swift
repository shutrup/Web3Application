//
//  WEB3APPApp.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

@main
struct WEB3APPApp: App {
    @StateObject var store = Store()
    var body: some Scene {
        WindowGroup {
            ContentView()
//            TabBarView()
//                .environmentObject(store)
//                .preferredColorScheme(.dark)
        }
    }
}
