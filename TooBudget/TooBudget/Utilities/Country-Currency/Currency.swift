//
//  Currency.swift
//  TooBudget
//
//  Created by Jorge Paiz on 3/22/24.
//

import Foundation
struct Currency: Codable, Equatable {
    let symbol: String
    let name: String
    let symbolNative: String
    let decimalDigits: Int
    let rounding: Double
    let code: String
    let namePlural: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case name = "name"
        case symbolNative = "symbol_native"
        case decimalDigits = "decimal_digits"
        case rounding = "rounding"
        case code = "code"
        case namePlural = "name_plural"
    }
}

extension Currency {
    init(data: Data) throws {
        self = try Utilities.newJSONDecoder().decode(Currency.self, from: data)
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
        symbol: String? = nil,
        name: String? = nil,
        symbolNative: String? = nil,
        decimalDigits: Int? = nil,
        rounding: Double? = nil,
        code: String? = nil,
        namePlural: String? = nil
    ) -> Currency {
        return Currency(
            symbol: symbol ?? self.symbol,
            name: name ?? self.name,
            symbolNative: symbolNative ?? self.symbolNative,
            decimalDigits: decimalDigits ?? self.decimalDigits,
            rounding: rounding ?? self.rounding,
            code: code ?? self.code,
            namePlural: namePlural ?? self.namePlural
        )
    }
    
    func jsonData() throws -> Data {
        return try Utilities.newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
