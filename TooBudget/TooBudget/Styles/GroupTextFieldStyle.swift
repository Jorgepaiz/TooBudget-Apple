//
//  GroupTextFieldStyle.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct GroupTextFieldStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(EdgeInsets(
                top: 18,
                leading: 8,
                bottom: 20,
                trailing: 10
            ))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.backdrop.gradient)
                    .stroke(.tint4.gradient.opacity(0.5), lineWidth: 1)
            )
    }
}

