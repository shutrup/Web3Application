//
//  CategoryView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 35) {
                ForEach(0..<5, id: \.self) { _ in
                    CategoryCellView(title: "Скучивание", minute: 10)
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
