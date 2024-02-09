//
//  CloseButtonView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/3/24.
//

import SwiftUI

struct CloseButtonView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        HStack {
            Spacer()
            Button(action: { dismiss() }) { Image(systemName: "xmark.circle.fill") }
                .font(.system(size: 25))
                .fontWeight(.light)
                .foregroundStyle(.shade1.gradient.opacity(0.5))
                .padding(Constants.paddingForCloseButton)
        }
    }
}

#Preview {
    CloseButtonView()
}

