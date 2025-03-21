//
//  AppButton.swift
//  Jolly
//
//  Created by Phuong Le Thi on 2025-03-19.
//

import SwiftUI

struct AppButton: View {
    let title: String
    let isDisabled: Bool
    let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.isDisabled = false
        self.action = action
    }
    
    init(title: String, isDisabled: Bool, action: @escaping () -> Void) {
        self.title = title
        self.isDisabled = isDisabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .disabled(isDisabled)
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isDisabled ?  Color.gray :
                                Color("ActiveButtonColor"))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.top, 5)
                .padding(.horizontal, 30)
                .shadow(radius: 10)
        }
    }
}

#Preview {
    AppButton(title: "Test Button", action: {})
}
