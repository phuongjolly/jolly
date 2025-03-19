//
//  PronounsView.swift
//  Jolly
//
//  Created by Phuong Le Thi on 2025-03-18.
//

import SwiftUI
struct PronounsView: View {
    @State private var selectedPronoun = "She/Her"

    let pronouns = ["She/Her", "He/His", "They/Them"]

    var body: some View {
        VStack {
            Text("Your Pronouns")
                .font(.title)
                .padding()

            List(pronouns, id: \.self) { pronoun in
                Button(action: {
                    selectedPronoun = pronoun
                }) {
                    HStack {
                        Text(pronoun)
                            .font(.title2)
                        Spacer()
                        if selectedPronoun == pronoun {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue))
                    .padding(.vertical, 4)
                }
                .buttonStyle(PlainButtonStyle()) // To remove the default button style
            }

            Spacer()
        }
        .navigationTitle("Pronouns")
    }
}
#Preview {
    PronounsView()
}
