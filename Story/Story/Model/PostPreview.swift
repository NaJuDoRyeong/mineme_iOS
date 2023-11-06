//
//  Content.swift
//  Story
//
//  Created by 김민령 on 2023/03/09.
//

import Foundation

struct Content {
    let id : Int
    let location : String
    let date : String
    let images :  [String]
    let text: String
    let sticker : Int?
}


//FIXME: temporary data set
struct Post : Encodable {
    var date : String
    var title : String
    var content : String
}

struct PostingData : Encodable {
    var date : String
    var location : String
    var content : String
    var images : [Data]
    var sticker : Int
}

struct PostPreview: Decodable {
    let date, thumbnail: String
    let postID: Int

    enum CodingKeys: String, CodingKey {
        case date, thumbnail
        case postID
    }
}

struct CalendarPostPreview {
    let day : Int
    let post : PostPreview?
}
