//
//  ArtistViewModel.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 02/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import Foundation

class ArtistViewModel {
    var trackId: Double
    var artistName: String
    var collectionName: String
    var trackName: String
    var artworkUrl: URL
    var trackPrice: Double
    var releaseDate: String
    var currency: String
    var primaryGenreName: String
    var longDescription: String

    init(trackId: Double, artistName: String, collectionName: String, trackName: String, artworkUrl: URL, trackPrice: Double, releaseDate: String, currency: String, primaryGenreName: String, longDescription: String) {

        self.trackId = trackId
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.artworkUrl = artworkUrl
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.longDescription = longDescription
    }
}
