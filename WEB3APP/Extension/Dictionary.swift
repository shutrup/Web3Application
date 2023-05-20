//
//  Dictionary.swift
//  DGUNH
//
//  Created by timur on 17.05.2023.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? key
            let escapedValue = String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? String(describing: value)
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
