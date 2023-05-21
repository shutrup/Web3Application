//
//  Exercise.swift
//  WEB3APP
//
//  Created by timur on 21.05.2023.
//

import Foundation

struct Exercise: Codable, Hashable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Results]
}

// MARK: - Result
struct Results: Codable, Hashable {
    let id: Int
    let title: String
    let photos: Photos
    let secondsTime, countCalories, point: Int

    enum CodingKeys: String, CodingKey {
        case title, photos, id
        case secondsTime = "seconds_time"
        case countCalories = "count_calories"
        case point
    }
}

struct Photos: Codable, Hashable {
    let the1: String

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}
