//
//  TextFieldStyles.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct TextFieldStyles: TextFieldStyle {
    var header = ""
    var iconName = ""
    var errorText = ""
    var errorColor = Color.warm2
    var normalColor = Color.principal
    var isEmpty = false
    var placeholder = ""
    
    private var iconExist: CGFloat {
        iconName.isEmpty ? 10 : 40
    }
    
    private var isError: Bool {
        !errorText.isEmpty
    }
    
    private var isErrorColor: Color {
        isError ? errorColor : normalColor
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        GroupBox {
            ZStack(alignment: .leading) {
                HStack(spacing: 10) {
                    if !iconName.isEmpty {
                        Image(systemName: iconName)
                            .frame(width: 20)
                            .font(.system(size: 18))
                            .foregroundStyle(normalColor.gradient)
                    }
                    configuration
                        .foregroundStyle(.principal)
                        .font(.body)
                        .fontWeight(.medium)
                        .kerning(1)
                        .placeholder(placeholder, when: isEmpty)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isErrorColor.gradient, lineWidth: 1)
                                .shadow(color: .gray, radius: 3)
                        )
                }
                if !header.isEmpty {
                    HStack {
                        Text(LocalizedStringKey(header))
                            .foregroundStyle(normalColor.opacity(0.7))
                            .font(.caption)
                            .fontWeight(.light)
                            .kerning(1)
                            .lineLimit(1)
                            .padding(.horizontal, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.tint4.gradient)
                            )
                    }
                    .offset(y: -18)
                    .padding(.leading, iconExist)
                    .padding(.trailing, 5)
                }
                if isError && !errorText.isEmpty {
                    HStack {
                        Text(LocalizedStringKey(errorText))
                            .foregroundStyle(errorColor)
                            .font(.footnote)
                            .fontWeight(.light)
                            .kerning(1)
                            .lineLimit(1)
                    }
                    .offset(y: 22)
                    .padding(.leading, iconExist)
                    .padding(.trailing, 5)
                }
            }
        }
        .groupBoxStyle(GroupTextFieldStyle())
    }
}

fileprivate extension View {
    private func placeholderBase<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading) -> some View {
            
            placeholderBase(when: shouldShow, alignment: alignment) {
                Text(LocalizedStringKey(text))
                    .foregroundStyle(.gray.opacity(0.4))
                    .font(.body)
                    .fontWeight(.medium)
                    .kerning(1)
            }
        }
}
