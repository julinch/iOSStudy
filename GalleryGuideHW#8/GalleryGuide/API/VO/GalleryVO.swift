//
//  GalleryVO.swift
//  GalleryGuide
//
//  Created by Juliya on 31.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation
import ObjectMapper



struct GalleryVO {
    var id: String?
    var name: String?
    var galleryDescription: String?
    var email: String?
    var facebook: String?
    var city: String?
    var schedule: String?
    var address: String?
    var galleryLogo: String?
    var link: String?
    var phone: String?
    var latitude: Double?
    var longitude: Double?
    
}

extension GalleryVO: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["objectId"]
        name <- map["name"]
        galleryDescription <- map["galleryDescription"]
        email <- map["email"]
        facebook <- map["facebook"]
        city <- map["city"]
        schedule <- map["schedule"]
        address <- map["address"]
        galleryLogo <- map["galleryLogo"]
        link <- map["link"]
        phone <- map["phone"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }

    
    
    
}
