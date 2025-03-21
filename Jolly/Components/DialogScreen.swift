//
//  DialogScreen.swift
//  Jolly
//
//  Created by Phuong Le Thi on 2025-03-19.
//

import SwiftUI

struct DialogScreen<Content: View> : View {
    var title: String = ""
    var content: Content
    
    init(title: String = "", @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body : some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
                NavTitle(title: title)
                Spacer()
                content
            }.padding(.bottom, 50)
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    DialogScreen(title: "Hello World") {
        Text("Hello World!")
    }
}
