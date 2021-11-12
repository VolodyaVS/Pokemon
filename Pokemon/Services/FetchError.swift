//
//  FetchError.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import Foundation

enum FetchError: Error {
    case badURL
    case badResponse
    case badData
}
