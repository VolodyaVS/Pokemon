//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var pokemonListViewModel = PokemonListViewModel()
    @State private var searchText = ""

    private var filteredPokemons: [Pokemon] {
            if searchText.isEmpty {
                return pokemonListViewModel.pokemons
            } else {
                return pokemonListViewModel.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPokemons) { pokemon in
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
            .searchable(text: $searchText)
        }
        .task {
            await pokemonListViewModel.getPokemons()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
