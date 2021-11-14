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
                    NavigationLink {
                        PokemonDetailsView(viewModel: PokemonDetailsViewModel(pokemon: pokemon))
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(pokemon.name.capitalized)")
                                    .font(.title)
                                HStack {
                                    Text("\(pokemon.type.capitalized)")
                                        .italic()
                                    Circle()
                                        .foregroundColor(pokemon.typeColor)
                                        .frame(width: 14)
                                }
                            }
                            Spacer()
                            PokemonImageView(imageURL: pokemon.imageURL, isListView: true)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokemons")
        }
        .task {
            await pokemonViewModel.getPokemons()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
