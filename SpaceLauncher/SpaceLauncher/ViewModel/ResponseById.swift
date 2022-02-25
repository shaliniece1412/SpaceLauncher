//
//  ResponseById.swift
//  SpaceLauncher
//
//  Created by 922235 on 25/02/22.
//

import Foundation

struct ResponseById: Codable {
    let id: Int?
    let name: String?
    let date_of_birth: String?
    let nationality: String?
    let bio: String?
    let profile_image_thumbnail: String?
    let type: Type?
}

struct Type: Codable {
    let id: Int?
    let name: String?
}
