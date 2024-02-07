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
    let id: String
    let name: String
    
    // content
    var signUpType: SignUpType
    var secondName: String
    var surname: String
    var secondSurname: String
    let email: String
    
    // log
    var notes: String
    let createdAt: Date
    var updateAt: Date
    
    // codign
    enum CodingKeys: CodingKey {
        case _id
        case _name
        case _signUpType
        case _secondName
        case _surname
        case _secondSurname
        case _email
        case _notes
        case _createdAt
        case _updateAt
    }
    
    // constructor
    init(
        id: String,
        name: String,
        signUpType: SignUpType = .email,
        secondName: String = "",
        surname: String = "",
        secondSurname: String = "",
        email: String,
        notes: String = "",
        createdAt: Date = .now,
        updateAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.signUpType = signUpType
        self.secondName = secondName
        self.surname = surname
        self.secondSurname = secondSurname
        self.email = email
        self.notes = notes
        self.createdAt = createdAt
        self.updateAt = updateAt
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
        self.notes = try container.decode(String.self, forKey: ._notes)
        self.createdAt = try container.decode(Date.self, forKey: ._createdAt)
        self.updateAt = try container.decode(Date.self, forKey: ._updateAt)
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
        try container.encode(notes, forKey: ._notes)
        try container.encode(createdAt, forKey: ._createdAt)
        try container.encode(updateAt, forKey: ._updateAt)
    }
    
    convenience init(id: String, fullname: String, email: String) {
        let parts = fullname.split(separator: " ")
        let name = String(parts.first ?? "")
        var surname: String {
            fullname
                .replacingOccurrences(of: name, with: " ")
                .trimmingCharacters(in: .whitespaces)
        }
        self.init(id: id, name: name, surname: surname, email: fullname)
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
