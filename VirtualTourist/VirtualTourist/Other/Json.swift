//
//  Json.swift
//  VirtualTourist
//
//  Created by Tristan Pudell-Spatscheck on 5/31/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
//Image info
struct ImgResponse: Decodable {
    let photos: ImgResponseData
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}
struct ImgResponseData: Decodable {
    let total: String
    let perpage: Int?
    let photo: [ImgInfo]?
    enum CodingKeys: String, CodingKey{
        case total = "total"
        case perpage = "perpage"
        case photo = "photo"
    }
}
struct ImgInfo: Decodable {
    let title: String?
    let ID: String?
    let secret: String?
    let server: String?
    let farm: Int?
    enum CodingKeys: String, CodingKey{
        case ID = "id"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
    }
}
