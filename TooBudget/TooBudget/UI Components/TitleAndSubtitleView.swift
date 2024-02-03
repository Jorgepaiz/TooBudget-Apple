//
//  TitleAndSubtitleView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct TitleAndSubtitleView: View {
    let title: String
    let subtitle: String
    var maxWidth: CGFloat = 300
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(LocalizedStringKey(title))
                .titleTextStyle(maxWidth: maxWidth)
            
            Text(LocalizedStringKey(subtitle))
                .subtitleTextStyle(maxWidth: maxWidth)
        }
        .padding(.top, 10)
    }
}

#Preview {
    TitleAndSubtitleView(
        title: "long_text_placeholder",
        subtitle: "long_text_placeholder"
    )
}
