//
//  YouTubeSearchResults.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 10/06/22.
//

import Foundation

struct YouTubeSearchResults: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IDElement
}

struct IDElement: Codable {
    let kind: String
    let videoId: String
}
