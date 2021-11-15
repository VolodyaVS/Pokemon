//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import SwiftUI

struct PokemonDetailsView: View {
    @StateObject var viewModel: PokemonDetailsViewModel
    @State private var scale: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .foregroundColor(viewModel.pokemon.typeColor)
                VStack {
                    HStack {
                        VStack {
                            Text(viewModel.pokemon.name.capitalized)
                                .font(.largeTitle)
                            Text(viewModel.pokemon.type.capitalized)
                                .italic()
                        }
                        PokemonImageView(imageURL: viewModel.pokemon.imageURL, isListView: false)
                    }
                    VStack {
                        Text(viewModel.pokemon.description.replacingOccurrences(of: "\n", with: ""))
                        .padding()
                        ParameterGroupView(attack: viewModel.pokemon.attack,
                                           defense: viewModel.pokemon.defense,
                                           height: viewModel.pokemon.height,
                                           weight: viewModel.pokemon.weight)
                    }
                    .scaleEffect(scale)
                    .onAppear {
                        let animation = Animation.spring(dampingFraction: 0.5)
                        let repeated = animation.repeatCount(1)

                        withAnimation(repeated) {
                            scale = 1
                        }
                    }
                }
            }
        }
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(
            viewModel: PokemonDetailsViewModel(
                pokemon: Pokemon(
                    id: 1,
                    name: "Pokemon",
                    imageURL: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334",
                    type: "Poison",
                    description: "Bulbasaur can be seen napping in bright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays,\nthe seed grows progressively larger.",
                    attack: 88,
                    defense: 98,
                    height: 30,
                    weight: 50
                )
            )
        )
    }
}
