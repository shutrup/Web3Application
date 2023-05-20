//
//  RoundedTextField.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 20.05.2023.
//

import SwiftUI

struct RoundedTexField: View {
    var placeholder: String
    @Binding var text: String
    var imageName = String()
    var isSecure = false
    var isCapitalization = false
    var imageColor: Color = .primary
    @State private var isSecured = true
    @State private var hideTitle = false
    var isImageVisible = true
    
    var body: some View {
        ZStack {
            TextField(placeholder, text: $text)
                .opacity(isSecured ? 0 : 1)
            
            SecureField(placeholder, text: $text)
                .opacity(isSecured ? 1 : 0)
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 45))
        .textFieldStyle(.plain)
        .keyboardType(isSecure ? .alphabet : .default)
        .autocapitalization(isCapitalization ? .sentences : .none)
        .disableAutocorrection(isSecure)
        .frame(width: UIScreen.main.bounds.width - 32, height: 54)
        .background(Color(.systemGray6).cornerRadius(10))
        .accentColor(.black)
        .overlay(
            Image(systemName: isSecure ? (isSecured ? "eye.fill" : "eye.slash.fill") : imageName)
                .foregroundColor(imageColor)
                .padding()
                .onTapGesture {
                    guard isSecure else {
                        return
                    }
                    
                    isSecured.toggle()
                },
            alignment: .trailing
        )
        .onChange(of: text) {
            hideTitle = !$0.isEmpty
        }
        .onAppear {
            isSecured = isSecure
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTexField(placeholder: "Title", text: .constant(""), isCapitalization: true)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

