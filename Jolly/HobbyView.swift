//
//  HobbyView.swift
//  Jolly
//
//  Created by Phuong Le Thi on 2025-03-19.
//

import SwiftUI
struct HobbyView: View {
    @State private var selectedHobby: String?
    @State private var isButtonActive: Bool = false
    @State private var nextStep: Bool = false

    let hobbies = ["Enjoying being alone", "With friends and family", "Meeting new people", "Engaging in hobbies", "Staying productive"]
    var body: some View {
        NavigationStack {
            NavigationView {
                DialogScreen(title: "Your Hobby") {
                    VStack {
                        Spacer()
                        ForEach(hobbies, id: \.self) { hobby in
                            Text(hobby)
                                .padding()
                                .frame(maxWidth: .infinity) // Make each option full width
                               
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.title3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(self.selectedHobby == hobby ? Color(hex:"#5E99D9") : Color(hex:" #B0B0B0"), lineWidth: 2)
                                )
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                                .onTapGesture {
                                    self.selectedHobby = hobby
                                    self.isButtonActive = true
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                        }
                        
                        Spacer()
                        
                        AppButton(title: "Continue") {
                            if isButtonActive {
                                nextStep = true
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(isPresented: $nextStep) {
                AgeView()
            }

        }
    }
    
}

#Preview {
    HobbyView()
}
