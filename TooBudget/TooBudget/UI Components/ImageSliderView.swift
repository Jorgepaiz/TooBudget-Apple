//
//  ImageSliderView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct ImageSliderView: View {
    let images: [String]
    var height: CGFloat = 100
    
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image(images[currentIndex])
            .resizable()
//            .scaleEffect(CGSize(width: 1.0, height: 4/3.0))
            .ignoresSafeArea()
            .padding(0)
            .frame(height: height)
            .shadow(color: .gray, radius: 12, x: 3, y: -10)
            .onReceive(timer, perform: { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    currentIndex = (currentIndex + 1) % images.count
                }
            })
    }
}

#Preview {
    ImageSliderView(
        images: [
            "Landing",
            "Landing2",
            "Landing3",
            "Landing4",
            "Landing5"
        ]
    )
}
