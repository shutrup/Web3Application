//
//  HomeViewModel.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import Foundation
import WalletConnectSwift
import SwiftUI
import Web3
import PromiseKit

final class HomeViewModel: ObservableObject {
    
    let userService: UserServiceProtocol
    let daysService: DaysServiceProtocol
    
    init(userService: UserServiceProtocol, daysService: DaysService) {
        self.userService = userService
        self.daysService = daysService
        if !Constants.userID.isEmpty {
            Task {
                await featchUserInfo()
            }
        }
    }
    
    @Published var tokcenCount: [Int] = []
    @Published var calendar: [Calendarr] = Calendarr.FETCH_MOCKE
    @Published
    var showSheet: Bool = false
    @Published
    var session: Session?
    {
        didSet {
            if session != nil , Constants.userID.isEmpty{
                showSheet = true
            }
        }
    }
    @Published
    var userName: String = ""
    @Published
    var currentWallet: Wallet?
    @Published
    var isConnecting: Bool = false
    @Published
    var isReconnecting: Bool = false
    @Published
    var walletConnect: WalletConnect?
    var pendingDeepLink: String?
    
    let deepLinkDelay = 0.5
    
    var isWrongChain: Bool {
        if let chainId = session?.walletInfo?.chainId, chainId != 5 {
            return true
        }
        return false
    }
    
    var walletAccount: String? {
        Constants.userID = (session?.walletInfo!.accounts[0].lowercased()) ?? ""
        print(Constants.userID)
        return session?.walletInfo!.accounts[0].lowercased()
    }
    
    var walletName: String {
        if let name = session?.walletInfo?.peerMeta.name {
            return name
        }
        return currentWallet?.name ?? ""
    }
    
    @MainActor
    func featchUserInfo() async {
        let result = await userService.getUserInfo()
        switch result {
        case.success(let data):
            userName = data.first_name
            Constants.userID = data.id
        case.failure(let error):
            print(error.message)
        }
    }
    
    @MainActor
    func fetchCountMonth() async {
        //
    }
    
    @MainActor
    func createUser() async {
        let result = await userService.createUser(id: Constants.userID, fullName: userName)
        switch result {
        case.success(let data):
            print(data)
        case.failure(let error):
            print(error.message)
        }
    }
    
    @MainActor func getDays() async {
        let result = await daysService.getDays()
        switch result {
        case.success(let data):
            print(data)
        case.failure(let error):
            print(error.message)
        }
    }
    
    
    
    //MARK: Smart Contract//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func chekBalanse() throws {
        let web3 = Web3(rpcURL: "https://rpc.ankr.com/eth_goerli")
        let contractAddress = try EthereumAddress(hex: "0xedc5A7c3f9269E1BB848bB9aACBB5BE1C82bE45f", eip55: true)
        let contract = try web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)
//        let f = try web3.eth.con
//        firstly {
//            try contract.balanceOf(address: EthereumAddress(hex: "0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8", eip55: true)).call()
//        }.done { outputs in
//            print(outputs["_balance"] as? BigUInt)
//        }.catch { error in
//            print("плохо")
//        }
        
        
        let myAddress = try EthereumAddress(hex: "0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8", eip55: true)
        firstly {
            web3.eth.getTransactionCount(address: myAddress, block: .latest)
        }.then { nonce in
            try contract.transferFrom(from: myAddress, to: EthereumAddress(hex: "0xbC395f352C35AeA56e885539aA5aC468326ECB8D", eip55: true), value: 1000000).send(from: myAddress, value: .none, gas: EthereumQuantity(quantity: BigUInt(1000000)), gasPrice: EthereumQuantity(quantity: 21.gwei))
        }.done { txHash in
            print(txHash)
        }.catch { error in
            print(error)
        }
    }
    
    
    func openWallet() {
        if let wallet = currentWallet {
            if let url = URL(string: wallet.formLinkForOpen()),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func connect(wallet: Wallet) {
        guard let walletConnect = walletConnect else { return }
        let connectionUrl = walletConnect.connect()
        pendingDeepLink = wallet.formWcDeepLink(connectionUrl: connectionUrl)
        currentWallet = wallet
    }
    
    func initWalletConnect() {
        print("init wallet connect: \(walletConnect == nil)")
        if walletConnect == nil {
            walletConnect = WalletConnect(delegate: self)
            if walletConnect!.haveOldSession() {
                withAnimation {
                    isConnecting = true
                }
                walletConnect!.reconnectIfNeeded()
            }
        }
    }
    
    func triggerPendingDeepLink() {
        guard let deepLink = pendingDeepLink else { return }
        pendingDeepLink = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + deepLinkDelay) {
            if let url = URL(string: deepLink), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Open app in App Store or do something else
            }
        }
    }
    
    func didSubscribe(url: WCURL) {
        triggerPendingDeepLink()
    }
    
    func sendTx(to: String) {
        guard let session = session,
              let client = walletConnect?.client,
              let from = walletAccount else {
            print("nil client or session")
            return
        }
        let tx = Client.Transaction(
            from: from,
            to: to,
            data: "",
            gas: nil,
            gasPrice: nil,
            value: "0x1",
            nonce: nil,
            type: nil,
            accessList: nil,
            chainId: nil,
            maxPriorityFeePerGas: nil,
            maxFeePerGas: nil)
        do {
            try client.eth_sendTransaction(url: session.url,
                                           transaction: tx) { [weak self] response in
                self?.handleResponse(response)
            }
            DispatchQueue.main.async {
                self.openWallet()
            }
        } catch {
            print("error sending tx: \(error)")
        }
    }
    
    func disconnect() {
        guard let session = session, let walletConnect = walletConnect else { return }
        try? walletConnect.client?.disconnect(from: session)
        withAnimation {
            self.session = nil
        }
        UserDefaults.standard.removeObject(forKey: WalletConnect.sessionKey)
    }
    
    private func handleResponse(_ response: Response) {
        DispatchQueue.main.async {
            if let error = response.error {
                print("got error sending tx: \(error)")
                return
            }
            do {
                let result = try response.result(as: String.self)
                print("got response result: \(result)")
            } catch {
                print("Unexpected response type error: \(error)")
            }
        }
    }
}

extension HomeViewModel: WalletConnectDelegate {
    func failedToConnect() {
        DispatchQueue.main.async { [unowned self] in
            withAnimation {
                isConnecting = false
                isReconnecting = false
            }
        }
    }

    func didConnect() {
        DispatchQueue.main.async { [unowned self] in
            withAnimation {
                isConnecting = false
                isReconnecting = false
                session = walletConnect?.session
                if currentWallet == nil {
                    currentWallet = Wallets.bySession(session: session)
                }
                
            }
        }
    }
    
    func didUpdate(session: Session) {
        var accountChanged = false
        if let curSession = self.session,
           let curInfo = curSession.walletInfo,
           let info = session.walletInfo,
           let curAddress = curInfo.accounts.first,
           let address = info.accounts.first,
           curAddress != address || curInfo.chainId != info.chainId {
            accountChanged = true
            do {
                let sessionData = try JSONEncoder().encode(session)
                UserDefaults.standard.set(sessionData, forKey: WalletConnect.sessionKey)
            } catch {
                print("Error saving session in update: \(error)")
            }
        }
        DispatchQueue.main.async { [unowned self] in
            withAnimation {
                self.session = session
            }
            if accountChanged {
                // Handle address change
            }
        }
    }

    func didDisconnect(isReconnecting: Bool) {
        if !isReconnecting {
            DispatchQueue.main.async { [unowned self] in
                withAnimation {
                    isConnecting = false
                    session = nil
                }
            }
        }
        DispatchQueue.main.async { [unowned self] in
            withAnimation {
                self.isReconnecting = isReconnecting
            }
        }
    }
}

