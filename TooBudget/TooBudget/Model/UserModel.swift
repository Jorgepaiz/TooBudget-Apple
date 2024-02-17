//
//  UserModel.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/7/24.
//

import Foundation
import SwiftData

@Model
final class UserModel: Codable {
    // identification
    @Attribute(.unique)
    var id: String
    let name: String
    
    // content
    var signUpType: SignUpType
    var secondName: String
    var surname: String
    var secondSurname: String
    let email: String
    @Relationship(deleteRule: .cascade) 
    var budgets: [BudgetModel]
    @Relationship(deleteRule: .nullify) 
    var currentBudget: BudgetModel?
    
    // log
    var notes: String
    let createdAt: Date
    var updatedAt: Date
    
    // coding
    enum CodingKeys: CodingKey {
        case _id
        case _name
        case _signUpType
        case _secondName
        case _surname
        case _secondSurname
        case _email
        case _budgets
        case _currentBudget
        case _notes
        case _createdAt
        case _updatedAt
    }
    
    // constructors
    init(
        id: String,
        name: String,
        signUpType: SignUpType = .email,
        secondName: String = "",
        surname: String = "",
        secondSurname: String = "",
        email: String,
        budgets: [BudgetModel] = [],
        currentBudget: BudgetModel? = nil,
        notes: String = "",
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.signUpType = signUpType
        self.secondName = secondName
        self.surname = surname
        self.secondSurname = secondSurname
        self.budgets = budgets
        self.currentBudget = currentBudget
        self.email = email
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: ._name)
        self.signUpType = try container.decode(SignUpType.self, forKey: ._signUpType)
        self.secondName = try container.decode(String.self, forKey: ._secondName)
        self.surname = try container.decode(String.self, forKey: ._surname)
        self.secondSurname = try container.decode(String.self, forKey: ._secondSurname)
        self.email = try container.decode(String.self, forKey: ._email)
        self.budgets = try container.decode([BudgetModel].self, forKey: ._budgets)
        self.currentBudget = try container.decode(BudgetModel.self, forKey: ._currentBudget)
        self.notes = try container.decode(String.self, forKey: ._notes)
        self.createdAt = try container.decode(Date.self, forKey: ._createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: ._updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(name, forKey: ._name)
        try container.encode(signUpType, forKey: ._signUpType)
        try container.encode(secondName, forKey: ._secondName)
        try container.encode(surname, forKey: ._surname)
        try container.encode(secondSurname, forKey: ._secondSurname)
        try container.encode(email, forKey: ._email)
//        try container.encode(budgets, forKey: ._budgets)
//        try container.encode(currentBudget, forKey: ._currentBudget)
        try container.encode(notes, forKey: ._notes)
        try container.encode(createdAt, forKey: ._createdAt)
        try container.encode(updatedAt, forKey: ._updatedAt)
    }
    
    convenience init(id: String, fullname: String, email: String) {
        let parts = fullname.split(separator: " ").map(String.init)
        let name = parts.first ?? ""
        let surname = parts.count > 1 ? parts[1] : ""
        
        self.init(id: id, name: name, surname: surname, email: email)
    }
}

extension UserModel {
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return nil
            }
            return dictionary
        } catch {
            print("Error to convert to dictionary the model: UserModel")
            return nil
        }
    }
}
