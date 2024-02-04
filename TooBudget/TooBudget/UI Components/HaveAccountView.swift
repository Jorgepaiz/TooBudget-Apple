//
//  HaveAccountView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import SwiftUI

struct HaveAccountView: View {
    var haveAccount = true
    let tapButton: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Text(haveAccount ? "have_account" : "have_not_account")
                .normalTextStyle()
            
            Button(haveAccount ? "btn_sign_in" : "btn_sign_up", action: tapButton)
                .buttonStyle(TextButtonStyle())
        }
    }
}

#Preview {
    HaveAccountView(tapButton: {})
}
