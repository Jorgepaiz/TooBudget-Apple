//
//  ToastView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/6/24.
//

import SwiftUI
import TipKit

enum ToastKind {
    case info
    case success
    case warning
    case error
}

private struct NotificationTip: Tip {
    let header: String
    let description: String
    
    var title: Text { Text(LocalizedStringKey(header)) }
    var message: Text? { Text(LocalizedStringKey(description)) }
}

struct ToastView: View {
    let title: String
    let message: String
    var kind = ToastKind.info
    
    private var tipColor: some ShapeStyle {
        var color: Color
        switch kind {
        case .info:
            color = .tint2
        case .success:
            color = .trueTetradic3
        case .warning:
            color = .trueTetradic2
        case .error:
            color = .trueTetradic1
        }
        return color.gradient.opacity(0.9)
    }
    
    
    var body: some View {
        VStack {
            if kind == .info {
                TipView(NotificationTip(header: title, description: message))
                    .tipViewStyle(InfoTipStyle())
                    .tipBackground(tipColor)
            } else if kind == .success {
                TipView(NotificationTip(header: title, description: message))
                    .tipViewStyle(SuccessTipStyle())
                    .tipBackground(tipColor)
            } else if kind == .warning {
                TipView(NotificationTip(header: title, description: message))
                    .tipViewStyle(WarningTipStyle())
                    .tipBackground(tipColor)
            } else {
                TipView(NotificationTip(header: title, description: message))
                    .tipViewStyle(ErrorTipStyle())
                    .tipBackground(tipColor)
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview {
    ToastView(
        title: "Title",
        message: "Message"
    )
}
