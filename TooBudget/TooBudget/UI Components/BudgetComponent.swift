//
//  BudgetComponent.swift
//  TooBudget
//
//  Created by Jorge Paiz on 3/17/24.
//

import SwiftUI

struct BudgetComponent: View {
    let budget: BudgetModel
    
    var body: some View {
        GroupBox {
            VStack {
                Text(budget.name)
                    .font(.title3)
                    .fontWeight(.light)
                    .kerning(1)
                    .lineLimit(1)
                
                Label(budget.type.name, systemImage: "")
                    .foregroundStyle(.trueTetradic1)
                    .font(.caption)
                    .fontWeight(.medium)
                    .kerning(1)
                    .lineLimit(1)
                    .offset(y: -10)
                
                Text("Updated at:")
                    .foregroundStyle(.principal.opacity(0.9))
                    .font(.caption2)
                    .fontWeight(.light)
                    .kerning(1)
                    .lineLimit(1)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.tint4.gradient)
                    )
                
                Text(budget.updatedAt.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption2)
                    .fontWeight(.light)
                    .kerning(1)
                    .lineLimit(1)
                
                Text(budget.updatedAt.formatted(date: .omitted, time: .shortened))
                    .font(.caption2)
                    .fontWeight(.light)
                    .kerning(1)
                    .lineLimit(1)
                    .padding(.bottom, 10)
                
                Text("Created at:")
                    .foregroundStyle(.principal.opacity(0.7))
                    .font(.caption2)
                    .fontWeight(.light)
                    .kerning(1)
                    .lineLimit(1)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.tint4.gradient)
                    )
                
                Text(budget.createdAt.formatted(date: .long, time: .omitted))
                    .font(.caption)
                    .fontWeight(.light)
                    .kerning(1)
                    .lineLimit(1)
            }
        }
        .groupBoxStyle(GroupBudgetStyle(budgetType: budget.type))
    }
}

struct GroupBudgetStyle: GroupBoxStyle {
    let budgetType: BudgetType
            
    private var groupColor: Color {
        switch budgetType {
        case .personal:
            return .tetradic1
        case .family:
            return .tetradic2
        case .special:
            return .tetradic3
        }
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(EdgeInsets(
                top: 25,
                leading: 8,
                bottom: 12,
                trailing: 8
            ))
            .overlay(
                UpperRoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(groupColor)
                    .frame(height: 20),
                alignment: .top
            )
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.backdrop.gradient)
                    .stroke(.tint4.gradient.opacity(0.5), lineWidth: 1)
            )
    }
}

struct UpperRoundedRectangle: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}

#Preview {
    let budget = BudgetModel(id: UUID(), name: "First Budget", type: .personal, owner: "my", notes: "my first note")
    return BudgetComponent(budget: budget)
}
