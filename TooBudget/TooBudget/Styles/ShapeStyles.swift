//
//  ShapeStyles.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct RectangleToLineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 1)
            .foregroundColor(.principal)
            .shadow(color: .gray, radius: 3, x: 3, y: 2)
    }
}

extension View {
    func rectangleToLineStyle() -> some View {
        self.modifier(RectangleToLineStyle())
    }
}

