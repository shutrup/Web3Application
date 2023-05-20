//
//  Data.swift
//  DGUNH
//
//  Created by timur on 17.05.2023.
//

import Foundation

extension Data {
    mutating func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
