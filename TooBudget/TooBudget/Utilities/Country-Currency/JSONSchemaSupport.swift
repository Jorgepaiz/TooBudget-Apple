//
//  JSONSchemaSupport.swift
//  TooBudget
//
//  Created by Jorge Paiz on 3/22/24.
//

import Foundation

typealias Country = [CountryElement]

extension Array where Element == Country.Element {
    init(data: Data) throws {
        self = try Utilities.newJSONDecoder().decode(Country.self, from: data)
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
    
    func jsonData() throws -> Data {
        return try Utilities.newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
