//
//  GroupStyles.swift
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

struct GroupToastStyle: GroupBoxStyle {
    let toastType: ToastType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(toastType.color)
                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
            )
            .padding([.leading, .bottom, .trailing])
        
    }
}
