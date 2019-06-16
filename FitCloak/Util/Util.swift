//
//  Util.swift
//  FitCloak
//
//  Created by Yuhei Miyazato on 2019/06/15.
//

import Foundation

class Util {

    static func getJSONData(_ name: String) throws -> Data? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)

        return try Data(contentsOf: url)
    }
}
