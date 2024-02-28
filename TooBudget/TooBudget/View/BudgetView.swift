//
//  BudgetView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import SwiftUI

struct BudgetView: View {
    @Bindable private var viewModel: BudgetViewModel
    
    init(_ viewModel: BudgetViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Budget View")
        Button("Logout") {
            viewModel.logOut()
        }
        .buttonStyle(.bordered)
        .onAppear {
            AnalyticsService.currentScreenView(.budget)
        }
    }
}

#Preview {
    BudgetView(BudgetViewModel(BudgetCoordinator(AppCoordinator())))
}
