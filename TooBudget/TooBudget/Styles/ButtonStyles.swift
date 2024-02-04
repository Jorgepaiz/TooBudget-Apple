//
//  PrincipalButtonStyle.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct PrincipalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity)
            .background((configuration.isPressed ? Color.shade1 : Color.principal).gradient)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .font(.headline)
            .fontWeight(.medium)
            .kerning(2)
            .shadow(color: .gray, radius: 3, x: 3, y: 3)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

struct SocialButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 40))
            .foregroundStyle((configuration.isPressed ? Color.shade1 : Color.principal).gradient)
            .scaleEffect(configuration.isPressed ? 1.10 : 1.0)
    }
}

struct TextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .fontWeight(.regular)
            .kerning(1)
            .foregroundStyle(.white.gradient)
            .frame(minWidth: 0, idealWidth: .infinity)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background((configuration.isPressed ? Color.shade1 : Color.principal).gradient)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

