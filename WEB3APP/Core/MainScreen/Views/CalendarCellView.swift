//
//  CalendarCellView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct CalendarCellView: View {
    let day: Days
    
    var date: String {
        let date = Date(date: day.day, format: "yyyy-MM-dd")
        return date?.toString(format: "dd") ?? ""
    }
    
    var body: some View {
        VStack {
            Text("\(date)")
                .font(.system(size: 25))
                .bold()
                .padding(.vertical, 16)
                .padding(.horizontal, 25)
                .frame(width: 83, height: 75)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(day.total_points >= 30 ? Color.accenttColor : Color.gray, lineWidth: 3)
            )
            
            if day.day == Date.now.isFormat {
                Circle()
                    .fill(Color.accenttColor)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

struct CalendarCellView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCellView(day: Days(day: "0", total_points: 0))
    }
}
