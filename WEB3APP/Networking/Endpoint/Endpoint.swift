//
//  Endpoint.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: [String: Any]? { get }
    var header: [String: String]? { get }
}
