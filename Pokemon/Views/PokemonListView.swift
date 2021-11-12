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
                        AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100,
                                           height: 100)
                            case .failure(_):
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
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
