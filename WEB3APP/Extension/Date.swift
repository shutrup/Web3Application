//
//  Date.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 21.05.2023.
//

import Foundation

extension Date {
    var isoFormatt: String {
        return toString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
    }
    
    var isFormat: String {
        return toString(format: "yyyy-MM-dd")
    }
    
    var isRuFormat: String {
        return toString(format: "dd.MM.yyyy")
    }
    
    func isSameDay(date: Date?) -> Bool {
        if let date = date {
            return Calendar.current.isDate(self, inSameDayAs: date)
        } else {
            return false
        }
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toString(date style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = style
        return formatter.string(from: self)
    }
    
    func toString(time style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = style
        return formatter.string(from: self)
    }
}

extension Date {
    init?(date: String?, format: String) {
        guard let date = date else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = formatter.date(from: date) {
            self = date
        } else {
            return nil
        }
    }
}

extension String {
    public enum DateFormatType {
        case localDateTimeSec
        case localDate
        case localTimeWithNoon
        case localPhotoSave
        case messageRTetriveFormat
        case emailTimePreview
        
        var stringFormat: String {
            switch self {
            case .localDateTimeSec: return "yyyy-MM-dd HH:mm:ss"
            case .localTimeWithNoon: return "hh:mm a"
            case .localDate: return "yyyy-MM-dd"
            case .localPhotoSave: return "yyyyMMddHHmmss"
            case .messageRTetriveFormat: return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            case .emailTimePreview: return "dd MMM yyyy, h:mm a"
            }
        }
    }
    
    func toDate(_ format: DateFormatType = .localDateTimeSec) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringFormat
        let date = dateFormatter.date(from: self)
        return date
    }
}
