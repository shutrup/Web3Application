//
//  ContentView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject
    var viewModel = HomeViewModel()
    
    var body: some View {
        HomeView()
            .environmentObject(viewModel)
            .onAppear {
                viewModel.initWalletConnect()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

