//
//  SocialMediaAccesView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct SocialMediaAccessView: View {
    var body: some View {
        VStack(spacing: 10) {
            // text
            HStack(spacing: 20) {
                Rectangle()
                    .rectangleToLineStyle()
                
                Text("social_media_text")
                    .annotationTextStyle()
                
                Rectangle()
                    .rectangleToLineStyle()
            }
            
            // icons
            HStack(spacing: 30) {
                Button(action: {}) { Image(systemName: "apple.logo") }
                Button(action: {}) { Image(systemName: "g.circle.fill") }
            }
            .buttonStyle(SocialButtonStyle())
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    SocialMediaAccessView()
}

