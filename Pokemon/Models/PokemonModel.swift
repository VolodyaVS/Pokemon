//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import Foundation

struct PokemonModel: Identifiable, Decodable {
    let pokemonID = UUID()

    let id: Int
    let name: String
    let imageURL: String
    let type: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "imageUrl"
        case type
        case description
    }
}
