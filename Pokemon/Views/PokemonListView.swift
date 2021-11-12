//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var pokemonViewModel = PokemonViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(pokemonViewModel.pokemons) { pokemon in
                    Text("\(pokemon.name)")
                }
            }
            .navigationTitle("Pokemons")
            .listStyle(.plain)
        }
        .task {
            await pokemonViewModel.getPokemons()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
            .preferredColorScheme(.dark)
    }
}
