//
//  Data+extension.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import Foundation

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
