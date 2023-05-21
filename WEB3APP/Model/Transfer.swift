//
//  Transfer.swift
//  WEB3APP
//
//  Created by timur on 21.05.2023.
//

import Foundation
import web3
import BigInt

public struct Transfer: ABIFunction {
    public static let name = "transfer"
    public let gasPrice: BigUInt? = nil
    public let gasLimit: BigUInt? = 23000
    public var contract: EthereumAddress
    public let from: EthereumAddress?

    public let to: EthereumAddress
    public let value: BigUInt

    public init(contract: EthereumAddress,
                from: EthereumAddress? = nil,
                to: EthereumAddress,
                value: BigUInt) {
        self.contract = contract
        self.from = from
        self.to = to
        self.value = value
    }

    public func encode(to encoder: ABIFunctionEncoder) throws {
        try encoder.encode(to)
        try encoder.encode(value)
    }
}
