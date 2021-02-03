//
//  ArtistViewModelRealm.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 03/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import Foundation
import RealmSwift

class ArtistViewModelRealm: Object {
    @objc dynamic var artistName: String?
    @objc dynamic var collectionName: String?
    @objc dynamic var trackName: String?
    @objc dynamic var artworkUrl: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var primaryGenreName: String?
    @objc dynamic var longDescription: String?
    @objc dynamic var currency: String?
    @objc dynamic var trackPrice: Double = 0.0
}
