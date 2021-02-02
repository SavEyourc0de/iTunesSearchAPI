//
//  artistItems.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 02/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import Foundation

struct ArtistItem {
    let trackId: Double
    let artistName: String
    let collectionName: String
    let trackName: String
    let artworkUrl: URL
    let trackPrice: Double
    let releaseDate: String
    let currency: String
    let primaryGenreName: String
    let longDescription: String
}
