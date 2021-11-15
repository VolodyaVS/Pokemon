//
//  ImageCache.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 15.11.2021.
//

import SwiftUI

class ImageCache {
    static var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get { ImageCache.cache[url] }
        set { ImageCache.cache[url] = newValue }
    }
}
