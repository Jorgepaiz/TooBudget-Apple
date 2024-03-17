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
//    var budgets: [BudgetModel]
    
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
//        let budget1 = BudgetModel(id: UUID(), name: "First Budget", type: .personal, owner: "my", notes: "my first note")
//        let budget2 = BudgetModel(id: UUID(), name: "Second Budget", type: .family, owner: "my", notes: "my second note")
//        let budget3 = BudgetModel(id: UUID(), name: "Third Budget", type: .special, owner: "my", notes: "my third notes")
//        let budgets = [budget1, budget2, budget3]
//        return BudgetListView(budgets: budgets)
        let query = Query<BudgetModel, [BudgetModel]>(sort: [
            SortDescriptor(\BudgetModel.name)
        ])
        return NavigationStack {
            BudgetListView(_budgets: query)
                .modelContainer(container)
        }
    } catch {
        fatalError("Failed to create model container")
    }
}
