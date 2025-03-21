//
//  NavTitle.swift
//  Jolly
//
//  Created by Phuong Le Thi on 2025-03-19.
//
import SwiftUI


struct NavTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title)
            .foregroundColor(.white)
            .padding(.top, 80)
    }
}


#Preview {
    ZStack {
        Color("BackgroundColor")
        VStack(alignment: .leading) {
            NavTitle(title: "Sample Title")
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    .ignoresSafeArea(.all)

}
