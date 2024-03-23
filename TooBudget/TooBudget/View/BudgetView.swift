//
//  BudgetView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import SwiftUI

struct BudgetView: View {
    @Bindable private var viewModel: BudgetViewModel
    @State private var budgets: [BudgetModel]
    @State private var searchText = ""
    private let constants = Constants.shared
    
    init(_ viewModel: BudgetViewModel) {
        self.viewModel = viewModel
        budgets = viewModel.getBudgets()
    }
    
    let items = Array(1...22)
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // main view
                VStack(spacing: 0) {
                    TitleAndSubtitleView(
                        title: "budget_title",
                        subtitle: "budget_subtitle",
                        maxWidth: constants.scrnPercForTitle(geometry)
                    )
                    
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "arrow.left")
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(TextButtonStyle())
                    .padding(.top)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(budgets) { budget in
                                BudgetComponent(budget: budget)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .padding(.horizontal)
        }
        .background(.backdrop.gradient)
        .background(.white)
        .onAppear {
            AnalyticsService.currentScreenView(.budget)
        }
    }
    
}

#Preview {
    BudgetView(BudgetViewModel(BudgetCoordinator(AppCoordinator())))
}
