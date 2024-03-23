//
//  CountryElement.swift
//  TooBudget
//
//  Created by Jorge Paiz on 3/22/24.
//

import Foundation
struct CountryElement: Codable, Equatable {
    let name: String
    let isoCode: String
    let phoneCode: String
    let flag: Flag
    let currency: Currency
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case isoCode = "isoCode"
        case phoneCode = "phoneCode"
        case flag = "flag"
        case currency = "currency"
    }
}

extension CountryElement {
    init(data: Data) throws {
        self = try Utilities.newJSONDecoder().decode(CountryElement.self, from: data)
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
        name: String? = nil,
        isoCode: String? = nil,
        phoneCode: String? = nil,
        flag: Flag? = nil,
        currency: Currency? = nil
    ) -> CountryElement {
        return CountryElement(
            name: name ?? self.name,
            isoCode: isoCode ?? self.isoCode,
            phoneCode: phoneCode ?? self.phoneCode,
            flag: flag ?? self.flag,
            currency: currency ?? self.currency
        )
    }
    
    func jsonData() throws -> Data {
        return try Utilities.newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
