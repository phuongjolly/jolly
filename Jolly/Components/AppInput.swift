//
//  AppInput.swift
//  Jolly
//
//  Created by Phuong Le Thi on 2025-03-19.
//
import SwiftUI

struct AppInput: View {
    let placeholder: String
    @Binding var value: String
    
    var body: some View {
        TextField(placeholder, text: $value)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .padding()
    }
}

