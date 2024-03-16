//
//  BudgetListView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/29/24.
//

import SwiftUI
import SwiftData

struct BudgetListView: View {
    @Query(
        sort: [
            SortDescriptor(\BudgetModel.name, order: .forward),
            SortDescriptor(\BudgetModel.owner)
        ]
    ) private var budgets: [BudgetModel]
    
    var body: some View {
        List {
            ForEach(budgets) { budget in
                NavigationLink(value: budget) {
                    VStack(alignment: .leading) {
                        Text(budget.name)
                            .font(.headline)
                        
                        Text(budget.type.name)
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: BudgetModel.self, configurations: config)
//        let budget = BudgetModel(id: UUID(), name: "My Budget", type: .family, owner: "my", notes: "my notes")
        let query = Query<BudgetModel, [BudgetModel]>(sort: [
            SortDescriptor(\BudgetModel.name)
        ])
//        let query2 = Query<BudgetModel, [BudgetModel]>()
        return NavigationStack {
            BudgetListView(_budgets: query)
                .modelContainer(container)
        }
    } catch {
        fatalError("Failed to create model container")
    }
}
