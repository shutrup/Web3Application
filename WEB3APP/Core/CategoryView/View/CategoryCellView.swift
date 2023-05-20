//
//  CategoryCellView.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct CategoryCellView: View {
    let title: String
    let minute: Int
    
    var body: some View {
        HStack {
            HStack {
                Image("ima")
                    .resizable()
                    .frame(width: 84, height: 47)
                
                VStack(alignment: .leading, spacing: 7) {
                    Text(title)
                        .font(.system(size: 27))
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
                    
                    Text("5")
                        .font(.system(size: 27))
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
        CategoryCellView(title: "Скручивания", minute: 10)
    }
}
