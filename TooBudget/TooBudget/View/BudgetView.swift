//
//  BudgetView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/8/24.
//

import SwiftUI

struct BudgetView: View {
    @Bindable private var viewModel: BudgetViewModel
    @State private var path = [BudgetModel]()
    @State private var searchText = ""
    
    init(_ viewModel: BudgetViewModel) {
        self.viewModel = viewModel
        path = viewModel.getBudgets()
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            BudgetListView()
                .navigationTitle("Budget")
                .navigationDestination(for: BudgetModel.self, destination: BudgetEditView.init)
                .searchable(text: $searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Go Home", systemImage: "arrowshape.backward", action: viewModel.goToHome)
                            .disabled(!viewModel.isThereDefaultBudget)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("LogOut", systemImage: "person.fill.xmark", action: viewModel.logOut)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Budget", systemImage: "plus", action: addBudget)
                    }
                }
        }
        .onAppear {
            AnalyticsService.currentScreenView(.budget)
        }
    }
    
    private func addBudget() {
        path = [viewModel.getNewBudget()]
    }
}

#Preview {
    BudgetView(BudgetViewModel(BudgetCoordinator(AppCoordinator())))
}
