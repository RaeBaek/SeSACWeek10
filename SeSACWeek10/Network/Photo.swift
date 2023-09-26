//
//  Photo.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/19.
//

import Foundation

// Cadable = Decodable + Incodable
struct Photo: Decodable, Hashable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable, Hashable {
    let id: String
    let created_at: String
    let urls: PhotoURL
    let width: CGFloat
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable {
    let full: String
    let thumb: String
}
