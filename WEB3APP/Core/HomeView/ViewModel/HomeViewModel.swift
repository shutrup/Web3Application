//
//  HomeViewModel.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import Foundation
import SwiftUI
import WalletConnectSwift
import BigInt

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

    @AppStorage("userID") var userID = String()
    @Published var days: [Days] = []
    @Published var day: Days? = nil
    @Published var month: CountMonth? = nil
    @Published var calendar: [Calendarr] = Calendarr.FETCH_MOCKE
    @Published var showSheet: Bool = false
    @Published var session: Session? {
        didSet {
            if session != nil, Constants.userID.isEmpty {
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
        case let .success(data):
            userName = data.first_name
            userID = data.id
        case let .failure(error):
            print(error.message)
        }
    }

    @MainActor
    func fetchCountMonth() async {
        let result = await daysService.getCountMouth()
        switch result {
        case let .success(success):
            month = success.first
        case let .failure(error):
            print(error.message)
        }
    }

    @MainActor
    func createUser() async {
        let result = await userService.createUser(id: Constants.userID, fullName: userName)
        switch result {
        case let .success(data):
            print(data)
        case let .failure(error):
            print(error.message)
        }
    }

    @MainActor func getDays() async {
        let result = await daysService.getDays()
        switch result {
        case.success(let data):
        days = data
        data.map {
                if $0.day == Date.now.isFormat {
                    day = $0
                }
            }
        case.failure(let error):
            print(error.message)
        }
    }
    
//    func contract() {
//
//        let keyStorage = EthereumKeyLocalStorage()
//        let account = (try? EthereumAccount.create(replacing: keyStorage, keystorePassword: "MY_PASSWORD"))!
//
//        guard let clientUrl = URL(string: "https://rpc.ankr.com/eth_goerli") else { return }
//        let client = EthereumHttpClient(url: clientUrl)
//        var d: BigUInt = 1
//        let gas = client.eth_gasPrice { (currentPrice) in
//            switch currentPrice {
//            case .success(let data):
//                print(data)
//                d = data
//            case .failure(let pohuy):
//                print("yai")
//            }
//
//        }
//
//
//        let function = Transfer(contract: "0xe5e38B06Edca4913b5469A7f1FA9010258002041", from: "0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8", to: "0xbC395f352C35AeA56e885539aA5aC468326ECB8D", value: BigUInt(0.1))
//        do {
//            let transaction = try function.transaction(gasPrice: d)
//            client.eth_sendRawTransaction(transaction, withAccount: account) { (txHash) in
//                print("TX Hash: \(txHash)")
//            }
//        } catch {
//            print("хуйна")
//        }
//
//
////        client.eth_sendRawTransaction(transaction, withAccount: account) { ( txHash) in
////            print("TX Hash: \(txHash)")
////        }
//    }
    
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




//    let abiString = """
//    [
//        {
//            "inputs": [],
//            "stateMutability": "nonpayable",
//            "type": "constructor"
//        },
//        {
//            "inputs": [
//                {
//                    "internalType": "address",
//                    "name": "tokenAdress",
//                    "type": "address"
//                }
//            ],
//            "name": "addPoints",
//            "outputs": [],
//            "stateMutability": "nonpayable",
//            "type": "function"
//        },
//        {
//            "inputs": [],
//            "name": "buyMembership",
//            "outputs": [],
//            "stateMutability": "payable",
//            "type": "function"
//        },
//        {
//            "inputs": [
//                {
//                    "internalType": "address",
//                    "name": "a",
//                    "type": "address"
//                }
//            ],
//            "name": "getBalances",
//            "outputs": [
//                {
//                    "internalType": "uint256",
//                    "name": "",
//                    "type": "uint256"
//                }
//            ],
//            "stateMutability": "view",
//            "type": "function"
//        }
//    ]
//    """ // some ABI string
//    let bytecode = Data.fromHex("608060405234801561001057600080fd5b5033600360006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506105b7806100616000396000f3fe6080604052600436106100345760003560e01c80635c58111914610039578063ad7b985e14610043578063c84aae171461006c575b600080fd5b6100416100a9565b005b34801561004f57600080fd5b5061006a6004803603810190610065919061032a565b610192565b005b34801561007857600080fd5b50610093600480360381019061008e919061032a565b61027f565b6040516100a09190610370565b60405180910390f35b66470de4df82000034146100f2576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016100e9906103e8565b60405180910390fd5b680821ab0d44149800006000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000208190555062278d004261014d9190610437565b600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002081905550565b674563918244f400006000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282546101e8919061046b565b9250508190555060008190508073ffffffffffffffffffffffffffffffffffffffff1663a9059cbb33674563918244f400006040518363ffffffff1660e01b81526004016102379291906104f3565b6020604051808303816000875af1158015610256573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061027a9190610554565b505050565b60008060008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549050919050565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006102f7826102cc565b9050919050565b610307816102ec565b811461031257600080fd5b50565b600081359050610324816102fe565b92915050565b6000602082840312156103405761033f6102c7565b5b600061034e84828501610315565b91505092915050565b6000819050919050565b61036a81610357565b82525050565b60006020820190506103856000830184610361565b92915050565b600082825260208201905092915050565b7f6d7573742070617920302e303220455448000000000000000000000000000000600082015250565b60006103d260118361038b565b91506103dd8261039c565b602082019050919050565b60006020820190508181036000830152610401816103c5565b9050919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b600061044282610357565b915061044d83610357565b925082820190508082111561046557610464610408565b5b92915050565b600061047682610357565b915061048183610357565b925082820390508181111561049957610498610408565b5b92915050565b6104a8816102ec565b82525050565b6000819050919050565b6000819050919050565b60006104dd6104d86104d3846104ae565b6104b8565b610357565b9050919050565b6104ed816104c2565b82525050565b6000604082019050610508600083018561049f565b61051560208301846104e4565b9392505050565b60008115159050919050565b6105318161051c565b811461053c57600080fd5b50565b60008151905061054e81610528565b92915050565b60006020828403121561056a576105696102c7565b5b60006105788482850161053f565b9150509291505056fea2646970667358221220b0f90f7ad1576b8d254a05d2fd082010ef576dc239771cb153e5b74544cd80c664736f6c63430008110033") // some ABI bite sequence
////    let web3 = Web3HttpProvider(url: URL(string: "https://rpc.ankr.com/eth_goerli")!, network: Networks.Goerli)
//    let network = Networks.Goerli
//    let provider = try InfuraProvider(net: network)
//    let web3 = Web3(provider: )
////    let contract = web3.contract(abiString, at: EthereumAddress(hex: "0x41dA1eF169bf5EB95716C7896E9e7aA5B6B4686C", eip55: true), abiVersion: 2)!
//
////    let parameters: [Any] = [...]
//
//    let contract = web3.contract(abiString)
//    let deployOp = contract.prepareDeploy(bytecode: bytecode, constructor: contract.contract.constructor)!
//    deployOp.transaction.from = "" // your address
//    deployOp.transaction.gasLimitPolicy = .manual(3000000)
//    let result = try await deployTx.writeToChain(password: "web3swift")
//
//    // MARK: Smart Contract//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
////    func chekBalanse() throws {
//
////
////
////        let web3 = Web3(rpcURL: "https://rpc.ankr.com/eth_goerli")
////        let contractAddress = try EthereumAddress(hex: "0xedc5A7c3f9269E1BB848bB9aACBB5BE1C82bE45f", eip55: true)
////        let contract = try web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)
////        let controlContractAddress = try EthereumAddress(hex: "0x41dA1eF169bf5EB95716C7896E9e7aA5B6B4686C", eip55: true)
////        let controlContract = try web3.eth.Contract(json: contractABI, abiKey: nil, address: controlContractAddress)
////
////        firstly {
////            try controlContract["buyMembership"]!().call(transactionOptions)
////        }.done { outputs in
////            print(outputs)
////        }.catch { error in
////            print(error)
////        }
////
//    ////        let myAddress = try EthereumAddress(hex: "0xd9f57fc7CDcAa2D11f49C0c9629432802355c6D8", eip55: true)
//    ////        firstly {
//    ////            web3.eth.getTransactionCount(address: myAddress, block: .latest)
//    ////        }.then { nonce in
//    ////            try controlContract.transfer(to: EthereumAddress(hex: "0xbC395f352C35AeA56e885539aA5aC468326ECB8D", eip55: true) , value: BigUInt(100000)).send(from: myAddress, value: .none, gas: EthereumQuantity(quantity: BigUInt(1000000)), gasPrice: EthereumQuantity(quantity: 21.gwei))
//    ////        }.done { txHash in
//    ////            print(txHash)
//    ////        }.catch { error in
//    ////            print(error)
//    ////        }
////    }
