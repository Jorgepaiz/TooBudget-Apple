//
//  BudgetEditView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/29/24.
//

import SwiftUI
import SwiftData

struct BudgetEditView: View {
    @Bindable var budget: BudgetModel
//    private let originalBudget: BudgetModel?
    
//    init(budget: Bindable<BudgetModel>) {
//        self._budget = budget
//        self.originalBudget = budget.wrappedValue
//    }
    
    var body: some View {
        Form {
            Section("Budget") {
                TextField("Name", text: $budget.name)
            }
            
            Section("Budget Type") {
                Picker("Type", selection: $budget.type) {
                    Text(BudgetType.personal.name).tag(BudgetType.personal)
                    Text(BudgetType.family.name).tag(BudgetType.family)
                    Text(BudgetType.special.name).tag(BudgetType.special)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Notes") {
                TextField("notes", text: $budget.notes)
            }
            
            Section("Log") {
                HStack {
                    Text("Owner:")
                    Text(budget.owner)
                }
                DatePicker("Created", selection: $budget.createdAt)
                    .disabled(true)
                DatePicker("Updated", selection: $budget.updatedAt)
                    .disabled(true)
            }
        }
        .navigationTitle("Edit Budget")
        .navigationBarTitleDisplayMode(.inline)
    }
    
//    private func isFormModified() -> Bool {
//        budget != originalBudget
//    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: BudgetModel.self, configurations: config)
        let budget = BudgetModel(id: UUID(), name: "My Budget", type: .family, owner: "my", notes: "my notes")
        return NavigationStack {
            BudgetEditView(budget: budget)
                .modelContainer(container)
        }
    } catch {
        fatalError("Failed to create model container")
    }
}
