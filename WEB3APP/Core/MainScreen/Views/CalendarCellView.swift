//
//  CalendarCellView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct CalendarCellView: View {
    let calendar: Calendarr
    
    var body: some View {
        VStack {
            Text("\(calendar.day)")
                .font(.system(size: 25))
                .bold()
                .padding(.vertical, 16)
                .padding(.horizontal, 25)
                .frame(width: 83, height: 75)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(calendar.isSuccess ? Color.accenttColor : Color.gray, lineWidth: 3)
            )
            
            if calendar.isSelected {
                Circle()
                    .fill(Color.accenttColor)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

struct CalendarCellView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCellView(calendar: Calendarr.FETCH_MOCKE.first!)
    }
}
