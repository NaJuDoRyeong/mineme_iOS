//
//  PostByRegion.swift
//  Story
//
//  Created by 김민령 on 2023/06/05.
//

import Foundation

struct PostByRegion: Decodable {
    let region, city: String
    let posts: [PostPreview]
}
