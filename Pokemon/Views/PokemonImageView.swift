//
//  PokemonImageView.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import SwiftUI

struct PokemonImageView: View {
    let imageURL: String
    let isListView: Bool

    var body: some View {
        CacheAsyncImage(url: URL(string: imageURL)!) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: isListView ? 100 : 150,
                           height: isListView ? 100 : 150)
                    .modifier(StyleForImage(isListView: isListView))
            case .failure(_):
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView(imageURL: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334", isListView: true)
    }
}
