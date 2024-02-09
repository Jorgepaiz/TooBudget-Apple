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
            .foregroundColor(.principal)
            .font(.largeTitle)
            .fontWeight(.thin)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .kerning(2)
            .frame(maxWidth: maxWidth)
    }
}

struct SubtitleTextStyle: ViewModifier {
    var maxWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.gray)
            .font(.callout)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .kerning(1)
            .frame(maxWidth: maxWidth)
    }
}

struct AnnotationTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.principal)
            .font(.subheadline)
            .fontWeight(.light)
            .kerning(1)
            .frame(width: 130)
    }
}

struct NormalTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.principal)
            .font(.body)
            .fontWeight(.light)
            .kerning(1)
    }
}

struct TitleTipStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.regular)
            .kerning(2)
            .foregroundStyle(.tint4)
    }
}

struct MessageTipStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.light)
            .kerning(1)
            .foregroundStyle(.shade3)
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
    
    func normalTextStyle() -> some View {
        self.modifier(NormalTextStyle())
    }
    
    func titleTipStyle() -> some View {
        self.modifier(TitleTipStyle())
    }
    
    func messageTipStyle() -> some View {
        self.modifier(MessageTipStyle())
    }
}

