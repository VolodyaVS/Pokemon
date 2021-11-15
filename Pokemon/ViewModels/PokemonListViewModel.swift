//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import Foundation

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published private(set) var pokemons = [Pokemon]()

    private let networkManager = NetworkManager()

    func getPokemons() async {
        pokemons = try! await networkManager.fetchPokemons()
    }
}
