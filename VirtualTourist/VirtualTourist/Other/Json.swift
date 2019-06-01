//
//  Json.swift
//  VirtualTourist
//
//  Created by Tristan Pudell-Spatscheck on 5/31/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
//Image info
struct ImgInfo: Decodable {
    let ID: String?
    let secret: String?
    let server: String?
    let farm: String?
    enum CodingKeys: String, CodingKey{
        case ID = "id"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
    }
}
