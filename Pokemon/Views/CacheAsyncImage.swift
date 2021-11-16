//
//  CacheAsyncImage.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 15.11.2021.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    @State private var phase: AsyncImagePhase = .empty

    private let url: URL?
    private let urlSession: URLSession
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    var body: some View {
        content(phase)
            .animation(transaction.animation, value: true)
            .task(id: url) {
                await load(url: url)
            }
    }

    init(url: URL?,
         urlCache: URLCache = .shared,
         scale: CGFloat = 1,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {

        let configuration = URLSessionConfiguration.default
        configuration.urlCache = urlCache
        configuration.requestCachePolicy = .returnCacheDataElseLoad

        self.url = url
        self.urlSession =  URLSession(configuration: configuration)
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    private func load(url: URL?) async {
        do {
            guard let url = url else { return }
            let request = URLRequest(url: url)
            let (data, _) = try await urlSession.data(for: request)

            if let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                phase = .success(image)
            }
        } catch {
            phase = .failure(error)
        }
    }
}
