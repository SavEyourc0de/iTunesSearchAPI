//
//  APIConstatants.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 04/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import Foundation

class API_CONSTANTS {

    public struct URL {
        static let BASE_URL: String = "https://itunes.apple.com/search?"
    }

    public struct PARAMETERS {
        static let TERM: String = "term"

        public struct COUNTRY {
            static let KEY: String = "country"
            static let VALUE: String = "au"
        }

        public struct MEDIA {
            static let KEY: String = "media"
            static let VALUE: String = "movie"
        }
    }
}
