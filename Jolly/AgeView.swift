//
//  Untitled.swift
//  Jolly
//
//  Created by Phuong Le Thi on 2025-03-19.
//

import SwiftUI
struct AgeView: View {
    @State private var selectedAge = "Under 18"
    @State private var isButtonActive: Bool = false
    @State private var nextStep: Bool = false

    let ages = ["Under 18", "18-25", "26-35", "36-45", "46-55", "56+"]
    var body: some View {
        NavigationStack {
            NavigationView {
                DialogScreen(title: "Your Age") {
                    VStack {
                        Spacer()
                        
                        ForEach(ages, id: \.self) { age in
                            Text(age)
                                .padding()
                                .frame(maxWidth: .infinity) // Make each option full width
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.title3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(self.selectedAge == age ? Color(hex:"#5E99D9") : Color(hex:" #B0B0B0"), lineWidth: 2)
                                )
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                                .onTapGesture {
                                    self.selectedAge = age
                                    self.isButtonActive = true
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                        }
                        
                        Spacer()
                        
                        AppButton(title: "Continue", action:   {
                            if isButtonActive {
                                nextStep = true
                            }
                        })
                    }
                }
            }
            .navigationDestination(isPresented: $nextStep) {
                AgeView()
            }

        }
    }
    
}

#Preview {
    AgeView()
}
