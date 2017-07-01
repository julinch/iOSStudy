//
//  WorkVO.swift
//  GalleryGuide
//
//  Created by Juliya on 03.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation
import ObjectMapper

struct WorkVO {
    var id: String?
    var author: String?
    var imgPicture: GetImageInfo?
    var size: String?
    var title: String?
    var type: String?
    var year: String?
    
}


extension WorkVO: Mappable {
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["objectId"]
        author <- map["author"]
        imgPicture <- map["imgPicture"]
        size <- map["size"]
        title <- map["title"]
        type <- map["type"]
        year <- map["year"]
    }

    
    
    
    
}

struct GetImageInfo: Mappable {
    var type: String?
    var name: String?
    var url: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map){
        type <- map["__type"]
        name <- map["name"]
        url <- map["url"]
    }
    
    
    
    
    
}
