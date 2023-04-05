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
}


//FIXME: temporary data set
struct Post : Encodable {
    var date : String
    var title : String
    var content : String
}
