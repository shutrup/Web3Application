//
//  Store.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import Foundation

class Store: ObservableObject {
    @Published var currenTab: Tab = .profile
}

enum Tab: String, CaseIterable {
    case profile, home, category
    
    var icon: String {
        switch self {
        case .profile:
            return "Profile"
        case .home:
            return "Home"
        case .category:
            return "Category"
        }
    }
}
