//
//  BudgetModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/7/24.
//

import Foundation
import SwiftData

@Model
final class BudgetModel: Codable {
//final class BudgetModel {
    // identification
    @Attribute(.unique) let id: UUID
    var name: String
    
    // content
    var type: BudgetType
    let owner: String
    
    //log
    var notes: String
    var createdAt: Date
    var updatedAt: Date
    
    
    // coding
    enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case owner
        case notes
        case created_at
        case updated_at
    }
    
    // constructors
init(
    id: UUID,
    name: String,
    type: BudgetType,
    owner: String,
    notes: String = "",
    createdAt: Date = Date(),
    updatedAt: Date = Date()
) {
    self.id = id
    self.name = name
    self.type = type
    self.owner = owner
    self.notes = notes
    self.createdAt = createdAt
    self.updatedAt = updatedAt
}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(BudgetType.self, forKey: .type)
        self.owner = try container.decode(String.self, forKey: .owner)
        self.notes = try container.decode(String.self, forKey: .notes)
        self.createdAt = try container.decode(Date.self, forKey: .created_at)
        self.updatedAt = try container.decode(Date.self, forKey: .updated_at)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(owner, forKey: .owner)
        try container.encode(notes, forKey: .notes)
        try container.encode(createdAt, forKey: .created_at)
        try container.encode(updatedAt, forKey: .updated_at)
    }
    
    convenience init(
        name: String = "",
        type: BudgetType = .special,
        owner: String = ""
    ) {
        self.init(
            id: .init(),
            name: name,
            type: type,
            owner: owner,
            notes: "",
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}

extension BudgetModel {
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return nil
            }
            return dictionary
        } catch {
            print("Error to convert to dictionary the model: BudgetModel")
            CrashlyticsService.logError(error)
            return nil
        }
    }
}


