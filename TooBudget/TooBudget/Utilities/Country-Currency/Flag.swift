//
//  Flag.swift
//  TooBudget
//
//  Created by Jorge Paiz on 3/22/24.
//

import Foundation

struct Flag: Codable, Equatable {
    let emoji: String
    let unicode: String
    
    enum CodingKeys: String, CodingKey {
        case emoji = "emoji"
        case unicode = "unicode"
    }
}

extension Flag {
    init(data: Data) throws {
        self = try Utilities.newJSONDecoder().decode(Flag.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        emoji: String? = nil,
        unicode: String? = nil
    ) -> Flag {
        return Flag(
            emoji: emoji ?? self.emoji,
            unicode: unicode ?? self.unicode
        )
    }
    
    func jsonData() throws -> Data {
        return try Utilities.newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
