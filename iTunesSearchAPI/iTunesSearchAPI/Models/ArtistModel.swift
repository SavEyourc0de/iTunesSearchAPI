//
//  ArtistModel.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 02/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import Foundation
import SwiftyJSON

class ArtistModel {
    var artistItems: [ArtistItem] = []

    init(json: JSON) {
        let data = json["results"].arrayValue

        for item in data {
            let trackId = item["trackId"].doubleValue
            let artistName = item["artistName"].stringValue
            let collectionName = item["collectionName"].stringValue
            let trackName = item["trackName"].stringValue
            let artworkUrl = item["artworkUrl100"].url!
            let trackPrice = item["trackPrice"].doubleValue
            let releaseDate = item["releaseDate"].stringValue
            let currency = item["currency"].stringValue
            let primaryGenreName = item["primaryGenreName"].stringValue
            let longDescription = item["longDescription"].stringValue

            artistItems.append(ArtistItem(trackId: trackId, artistName: artistName, collectionName: collectionName, trackName: trackName, artworkUrl: artworkUrl, trackPrice: trackPrice, releaseDate: releaseDate, currency: currency, primaryGenreName: primaryGenreName, longDescription: longDescription))
        }
    }
}
