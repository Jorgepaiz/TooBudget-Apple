//
//  TextStyles.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct TitleTextStyle: ViewModifier {
    var maxWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.shade3)
            .font(.largeTitle)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .frame(maxWidth: maxWidth)
    }
}

struct SubtitleTextStyle: ViewModifier {
    var maxWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.shade3)
            .font(.callout)
            .fontWeight(.thin)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .frame(maxWidth: maxWidth)
    }
}

struct AnnotationTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.shade3)
            .font(.subheadline)
            .fontWeight(.light)
            .frame(width: 130)
    }
}

extension View {
    func titleTextStyle(maxWidth: CGFloat = 300) -> some View {
        self.modifier(TitleTextStyle(maxWidth: maxWidth))
    }
    
    func subtitleTextStyle(maxWidth: CGFloat = 300) -> some View {
        self.modifier(SubtitleTextStyle(maxWidth: maxWidth))
    }
    
    func annotationTextStyle() -> some View {
        self.modifier(AnnotationTextStyle())
    }
}

