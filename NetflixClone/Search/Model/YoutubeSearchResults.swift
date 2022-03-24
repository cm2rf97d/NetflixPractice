//
//  YoutubeSearchResults.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/3/16.
//

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
