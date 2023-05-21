//
//  Days.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 21.05.2023.
//

import Foundation

struct Days: Codable, Hashable {
    var exerciseuser__date: String
    var point__sum: Int
}

struct Dayslist: Codable, Hashable {
    let id: Int
    let title: String
    let photos: Photos
    let secondsTime, countCalories, point: Int
    let user: [String]

    enum CodingKeys: String, CodingKey {
        case title, photos, id
        case secondsTime = "seconds_time"
        case countCalories = "count_calories"
        case point
        case user
    }
}

