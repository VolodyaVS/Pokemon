//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import SwiftUI
import Kingfisher

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
                        KFImage(URL(string: pokemon.imageURL))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
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
