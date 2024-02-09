//
//  ToastView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/9/24.
//

import SwiftUI

struct ToastView: View {
    let title: String
    let message: String
    var showing: Binding<Bool> = .constant(true)
    var type: ToastType = .info
    
    let closeIconSize: CGFloat = 20
    let cornerPadding: CGFloat = 10
    let headlineKerning: CGFloat = 2
    let subheadlineKerning: CGFloat = 1
    
    var body: some View {
        if showing.wrappedValue {
            GroupBox {
                VStack {
                    HStack {
                        Text(LocalizedStringKey(title))
                            .font(.headline)
                            .fontWeight(.medium)
                            .kerning(headlineKerning)
                            .foregroundStyle(.tint4)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button("close",
                               systemImage: "xmark.circle",
                               action: {
                            withAnimation {
                                showing.wrappedValue.toggle()
                            }
                        })
                        .labelStyle(.iconOnly)
                        .font(.system(size: closeIconSize))
                        .fontWeight(.light)
                        .foregroundStyle(.tint4.gradient.opacity(1.0))
                        .padding([.top, .trailing], cornerPadding)
                    }
                    HStack(alignment: .top) {
                        Image(systemName: type.icon)
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundStyle(.tint4.gradient)
                            .padding([.leading, .bottom])
                        
                        Text(LocalizedStringKey(message))
                            .font(.subheadline)
                            .fontWeight(.light)
                            .kerning(subheadlineKerning)
                            .foregroundStyle(.shade3)
                            .padding(.bottom)
                        
                        Spacer()
                    }
                }
            }
            .groupBoxStyle(GroupToastStyle(toastType: type))
        }
    }
}

#Preview {
    ToastView(
        title: "Title of the Toast",
        message: "Long message of the Toast"
    )
}
