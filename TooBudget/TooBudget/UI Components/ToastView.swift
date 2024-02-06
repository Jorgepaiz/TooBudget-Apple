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

struct NotificationTip: Tip {
    let header: String
    let description: String
    
    var title: Text { Text(LocalizedStringKey(header)) }
    var message: Text? { Text(LocalizedStringKey(description)) }
}

struct ToastView: View {
    let title: String
    let message: String
    var kind = ToastKind.info
    
    var body: some View {
        VStack {
            if kind == .info {
                TipView(NotificationTip(header: title, description: message))
                    .tipViewStyle(InfoTipStyle())
                    .tipBackground(.tint2.gradient.opacity(0.9))
            } else if kind == .success {
                TipView(NotificationTip(header: title, description: message))
                    .tipViewStyle(SuccessTipStyle())
                    .tipBackground(.trueTetradic3.gradient.opacity(0.9))
            } else if kind == .warning {
                TipView(NotificationTip(header: title, description: message))
                    .tipViewStyle(WarningTipStyle())
                    .tipBackground(.trueTetradic2.gradient.opacity(0.9))
            } else {
                TipView(NotificationTip(header: title, description: message))
                    .tipViewStyle(ErrorTipStyle())
                    .tipBackground(.trueTetradic1.gradient.opacity(0.9))
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
