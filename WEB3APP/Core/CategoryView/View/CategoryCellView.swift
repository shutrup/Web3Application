//
//  CategoryCellView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryCellView: View {
    let title: String
    let minute: Int
    let point: Int
    let imageUrl: String
    
    var body: some View {
        HStack {
            HStack {
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .frame(width: 84, height: 50)
                
                VStack(alignment: .leading, spacing: 7) {
                    Text(title)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("\(minute)")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .opacity(0.86)
                        
                        Text("минут")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .opacity(0.86)
                    }
                }
                
                Spacer()
                
                HStack(alignment: .center) {
                    Image("primary")
                        .resizable()
                        .frame(width: 15, height: 20)
                        .foregroundColor(.accenttColor)
                    
                    Text("\(point)")
                        
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, minHeight: 119,alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.accenttColor.opacity(0.77), lineWidth: 3)
        )
        .padding(.horizontal)
    }
}

struct CategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCellView(title: "Скручивания", minute: 10, point: 0, imageUrl: "")
    }
}
