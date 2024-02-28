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
    let type: BudgetType
    let owner: String
    
    //log
    var notes: String
    let createdAt: Date
    var updatedAt: Date
    
    
    // coding
    enum CodingKeys: CodingKey {
        case _id
        case _name
        case _type
        case _owner
        case _notes
        case _createdAt
        case _updatedAt
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
        self.id = try container.decode(UUID.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: ._name)
        self.type = try container.decode(BudgetType.self, forKey: ._type)
        self.owner = try container.decode(String.self, forKey: ._owner)
        self.notes = try container.decode(String.self, forKey: ._notes)
        self.createdAt = try container.decode(Date.self, forKey: ._createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: ._updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(name, forKey: ._name)
        try container.encode(type, forKey: ._type)
        try container.encode(owner, forKey: ._owner)
        try container.encode(notes, forKey: ._notes)
        try container.encode(createdAt, forKey: ._createdAt)
        try container.encode(updatedAt, forKey: ._updatedAt)
    }
    
    convenience init(name: String, type: BudgetType = .personal, owner: String) {
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


