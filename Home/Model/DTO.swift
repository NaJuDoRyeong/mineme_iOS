//
//  DTO.swift
//  Home
//
//  Created by 김민령 on 2023/02/10.
//

import Foundation

struct MainData : Decodable {
    let couple: Couple
    let newStory: NewStory
    let widgets: [WidgetInfo]
}

struct Couple: Decodable {
    let name, startDate: String
    let me, mine: PersonInfo
}

struct PersonInfo: Codable {
    let profileImage: String
    let nickname, birthday: String
    let instaId, gender, description: String?
    
    enum CodingKeys: String, CodingKey {
        case profileImage, nickname, description
        case instaId
        case birthday, gender
    }
    
    func toDomain() -> Profile? {
        
        let name = nickname
        let image = profileImage
//        let birthday = birthday
        guard let instaId = instaId else { return nil }
        guard let comment = description else { return nil }
        guard let gender = gender else { return nil }
//        let code = code
        
        return .init(name: name, image: image , instaId: instaId, comment: comment, gender: gender)
    }
}

struct NewStory: Codable {
    let postId: Int
    let region, date: String
    let thumbnailImage: String
    
    enum CodingKeys: String, CodingKey {
        case postId
        case region, date, thumbnailImage
    }
}

struct WidgetInfo: Codable {
    let id, order: Int
    let type, name, color: String
    let width, height: Int
    let widget: WidgetDetail
}

struct WidgetDetail: Codable {
    let date, fontStyle: String?
    let background: String?
    let ypos, xpos: String?
    let contents: [String]?
}
