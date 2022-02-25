//
//  LauncherResponse.swift
//  SpaceLauncher
//
//  Created by 922235 on 25/02/22.
//

import Foundation

struct LauncherResponse: Codable {
    var results: [ResultsResponse]
}

struct ResultsResponse: Codable {
    let id: Int?
    let name: String?
    var status: Status?
    let nationality: String?
    let wiki: String?
    let profile_image: String?
    let profile_image_thumbnail: String?
    let first_flight: String?
}

struct Status: Codable {
    let id: Int?
    let name: String?
}

