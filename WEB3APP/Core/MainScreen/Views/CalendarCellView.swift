//
//  CalendarCellView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct CalendarCellView: View {
    let day: Int
    var body: some View {
        Text("\(day)")
            .font(.system(size: 27))
            .bold()
            .padding(.vertical, 16)
            .padding(.horizontal, 24.5)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.accenttColor, lineWidth: 3)
            )
    }
}

struct CalendarCellView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCellView(day: 1)
    }
}
