//
//  ContentView.swift
//  Jolly
//
//  Created by Phuong Le Thi on 2025-03-17.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var isActive = false

    var body: some View {
        NavigationStack {
            NavigationView {
                VStack {
                    TextField("Enter your name", text: $name)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        if !name.isEmpty {
                            isActive = true
                        }
                    }) {
                        Text("Continue")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(name.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                    .disabled(name.isEmpty) // Disable if name is empty
                }
                .navigationTitle("Enter your Name")
            }
            .navigationDestination(isPresented: $isActive) {
                PronounsView()
            }
        }

    }
}

#Preview {
    ContentView()
}
