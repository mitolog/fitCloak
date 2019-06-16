// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gymItems = try GymItems(json)

import Foundation
import UIKit

// MARK: - GymItem
struct GymItem: Codable {
    let id: Int
    let name, address, opentime, closetime: String
    let phone: String
    let lat, lng: Double
}

// MARK: GymItem convenience initializers and mutators

extension GymItem {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GymItem.self, from: data)
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
        id: Int? = nil,
        name: String? = nil,
        address: String? = nil,
        opentime: String? = nil,
        closetime: String? = nil,
        phone: String? = nil,
        lat: Double? = nil,
        lng: Double? = nil
        ) -> GymItem {
        return GymItem(
            id: id ?? self.id,
            name: name ?? self.name,
            address: address ?? self.address,
            opentime: opentime ?? self.opentime,
            closetime: closetime ?? self.closetime,
            phone: phone ?? self.phone,
            lat: lat ?? self.lat,
            lng: lng ?? self.lng
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias GymItems = [GymItem]

extension Array where Element == GymItems.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GymItems.self, from: data)
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
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
