//
//  Calendar.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 21.05.2023.
//

import Foundation

struct Calendarr: Hashable {
    let day: Int
    let isSuccess: Bool
    let currentDay = Date()
    let isSelected: Bool
}

extension Calendarr {
    static var FETCH_MOCKE: [Calendarr] = [
        Calendarr(day: 1, isSuccess: true, isSelected: false),
        Calendarr(day: 2, isSuccess: true, isSelected: false),
        Calendarr(day: 3, isSuccess: true, isSelected: false),
        Calendarr(day: 4, isSuccess: true, isSelected: false),
        Calendarr(day: 5, isSuccess: true, isSelected: false),
        Calendarr(day: 6, isSuccess: true, isSelected: false),
        Calendarr(day: 7, isSuccess: true, isSelected: false),
        Calendarr(day: 8, isSuccess: true, isSelected: false),
        Calendarr(day: 9, isSuccess: true, isSelected: false),
        Calendarr(day: 10, isSuccess: true, isSelected: false),
        Calendarr(day: 11, isSuccess: true, isSelected: false),
        Calendarr(day: 12, isSuccess: true, isSelected: false),
        Calendarr(day: 13, isSuccess: true, isSelected: false),
        Calendarr(day: 14, isSuccess: true, isSelected: false),
        Calendarr(day: 15, isSuccess: true, isSelected: false),
        Calendarr(day: 16, isSuccess: true, isSelected: false),
        Calendarr(day: 17, isSuccess: true, isSelected: false),
        Calendarr(day: 18, isSuccess: true, isSelected: false),
        Calendarr(day: 19, isSuccess: true, isSelected: false),
        Calendarr(day: 20, isSuccess: true, isSelected: false),
        Calendarr(day: 21, isSuccess: false, isSelected: true),
        Calendarr(day: 22, isSuccess: false, isSelected: false),
        Calendarr(day: 23, isSuccess: false, isSelected: false),
        Calendarr(day: 24, isSuccess: false, isSelected: false),
        Calendarr(day: 25, isSuccess: false, isSelected: false),
        Calendarr(day: 26, isSuccess: false, isSelected: false),
        Calendarr(day: 27, isSuccess: false, isSelected: false),
        Calendarr(day: 28, isSuccess: false, isSelected: false),
        Calendarr(day: 29, isSuccess: false, isSelected: false),
        Calendarr(day: 30, isSuccess: false, isSelected: false)
    ]
}
