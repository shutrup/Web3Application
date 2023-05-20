//
//  HomeView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    @StateObject var store = Store()
    
    var body: some View {
        if vm.session == nil {
            VStack {
                Text("Connect to:")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                
                Button {
                    vm.connect(wallet: Wallets.Metamask)
                } label: {
                    HStack {
                        Spacer()
                        Text(Wallets.Metamask.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(.vertical, 15)
                    .background(Color.accentColor)
                    .cornerRadius(32)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 24)
            }
        } else {
            TabBarView()
                .environmentObject(store)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
