//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 14.11.2021.
//

import SwiftUI

class PokemonDetailsViewModel: ObservableObject {
    @Published var pokemon: Pokemon

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
