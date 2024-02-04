//
//  ToggleStyles.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/3/24.
//

import SwiftUI

struct MainToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(configuration.isOn ? .tint2 : .tint3)
                .frame(width: 40, height: 18)
                .overlay(
                    Circle()
                        .fill(.principal.gradient)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10, y: 0)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
                .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 3, y: 3)
            
            configuration.label
                .font(.headline)
                .fontWeight(.light)
                .foregroundColor(.shade2)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 3, y: 3)
        }
    }
}

struct CheckBoxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 5) {
            ZStack(alignment: .center) {
                Image(systemName: "rectangle")
                    .font(.system(size: 15))
                    .foregroundStyle(.tint2)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
                    .offset(y: 1)
                
                if configuration.isOn {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundStyle(configuration.isOn ? .tint1 : .clear)
                        .onTapGesture {
                            configuration.isOn.toggle()
                        }
                        .offset(x: 3, y: -2)
                }
            }
            
            configuration.label
                .font(.subheadline)
                .fontWeight(.light)
                .kerning(1)
                .foregroundColor(.principal)
//                .shadow(color: .gray.opacity(0.5), radius: 2, x: 3, y: 3)
        }
    }
}

