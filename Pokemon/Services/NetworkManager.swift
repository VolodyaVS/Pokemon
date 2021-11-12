//
//  NetworkManager.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import Foundation

class NetworkManager {
    func fetchPokemons() async throws -> [Pokemon] {
        guard let url = URL(string: "https://gist.githubusercontent.com/VolodyaVS/f1a0c44be813fd6b5cf9d39c8142dc2d/raw/28f76b9efce6da402cc672f34db0ac8bdb6e1df4/PokemonAPI") else { throw FetchError.badURL }
        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData }

        let pokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        return pokemonData
    }
}
