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
            Text("Connected to \(vm.walletName)")
                .font(.system(size: 17))
                .fontWeight(.bold)
            
            Text("Address: \(vm.walletAccount ?? "")")
                .font(.system(size: 13))
                .fontWeight(.regular)
                .lineLimit(1)
                .truncationMode(.middle)
                .padding(.top, 10)
                .padding(.horizontal, 20)
            
            if vm.isWrongChain {
                Text("Connected to wrong chain. Please connect to Polygon")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
            } else {
                Button {
                    vm.sendTx(to: "0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8")
                } label: {
                    HStack {
                        Spacer()
                        Text("Send tx")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(.vertical, 15)
                    .background(Color.accenttColor)
                    .cornerRadius(32)
                }
                .padding(.horizontal, 30)
                .padding(.top, 30)
            }
            
            Button {
                vm.disconnect()
            } label: {
                HStack {
                    Spacer()
                    Text("Disconnect")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.vertical, 15)
                .background(Color.red)
                .cornerRadius(32)
            }
            .padding(.horizontal, 30)
            .padding(.top, 60)
            .sheet(isPresented: $vm.showSheet) {
                VStack {
                    Text("Введите имя")
                        .font(.title2)
                    
                    RoundedTexField(placeholder: "Name", text: $vm.userName, imageName: "chekmark", isSecure: false, isCapitalization: true, imageColor: .black)
                    
                    Button {
                        vm.showSheet.toggle()
                    } label: {
                        Text("Сохранить")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 340, height: 50)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                            .padding()
                    }
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                }
                .presentationDetents([.fraction(0.3)])
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
