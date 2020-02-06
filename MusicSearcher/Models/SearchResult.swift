//
//  SearchResult.swift
//  MusicSearcher
//
//  Created by Станислав Жук on 05.02.2020.
//  Copyright © 2020 InsiderGroup. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl60: String?
}
