//
//  TextCustomizer.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import Foundation

import SwiftUI

struct TextCustomizer {
    static func customText(_ placeholder: String) -> some View {
        Text(placeholder)
            .font(.title2)
            .fontWeight(.regular)
    }

    static func customTextField(_ placeholder: String, text: Binding<String>, isPassword: Bool = false, isEmail: Bool = false) -> some View
    {
        Group {
            if isEmail {
                TextField(placeholder, text: text)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else if !isPassword {
                TextField(placeholder, text: text)

            } else {
                SecureField(placeholder, text: text)
            }
        }
        .padding()
        .frame(width: 300, height: 50)
        .background(Color.black.opacity(0.10))
        .cornerRadius(10)
    }
}
