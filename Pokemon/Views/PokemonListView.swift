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

    @ObservedObject var networkMonitor = NetworkMonitor()

    private var filteredPokemons: [Pokemon] {
        if searchText.isEmpty {
            return pokemonListViewModel.pokemons
        } else {
            return pokemonListViewModel.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        if !networkMonitor.isConnected {
            VStack {
                Image(systemName: "wifi.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                Text("Please check your Internet connection")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
        } else {
            NavigationView {
                List {
                    ForEach(filteredPokemons) { pokemon in
                        NavigationLink {
                            PokemonDetailsView(viewModel: PokemonDetailsViewModel(pokemon: pokemon))
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("\(pokemon.name.capitalized)")
                                            .font(.title)
                                        if pokemon.isFavorite {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                        }
                                    }
                                    HStack {
                                        Text("\(pokemon.type.capitalized)")
                                            .italic()
                                        Circle()
                                            .foregroundColor(pokemon.typeColor)
                                            .frame(width: 14)
                                    }
                                }
                                Spacer()
                                PokemonImageView(imageURL: pokemon.imageURL,
                                                 isListView: true)
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                addFavorite(for: pokemon)
                            } label: {
                                Image(systemName: "star")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                withAnimation {
                                    if let index = pokemonListViewModel.pokemons.firstIndex(
                                        where: { $0.id == pokemon.id }
                                    ) {
                                        pokemonListViewModel.pokemons.remove(at: index)
                                    }
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Pokemons")
                .searchable(text: $searchText)
                .refreshable {
                    await pokemonListViewModel.getPokemons()
                }
                .task {
                    await pokemonListViewModel.getPokemons()
                }
            }
        }
    }
    
    private func addFavorite(for pokemon: Pokemon) {
        if let index = pokemonListViewModel.pokemons.firstIndex(where: { $0.id == pokemon.id }) {
            withAnimation {
                pokemonListViewModel.pokemons[index].isFavorite.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
