//
//  StoryDTO.swift
//  Story
//
//  Created by 김민령 on 2023/03/16.
//

import Foundation

//FIXME: temporary data set
struct PostDTO : Codable{
    var date : String
    var title : String
    var content : String
}

struct ImagesDTO : Decodable {
    var images : [String]
}
