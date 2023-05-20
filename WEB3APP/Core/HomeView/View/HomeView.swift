//
//  HomeView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    var body: some View {
        VStack {
            Text("Connect to:")
                .font(.system(size: 17))
                .fontWeight(.bold)
            
            Button {
                vm.connect(wallet: Wallets.TrustWallet)
            } label: {
                HStack {
                    Spacer()
                    Text(Wallets.TrustWallet.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.vertical, 15)
                .background(Color.blue)
                .cornerRadius(32)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 24)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
