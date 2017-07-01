//
//  GalleryImage.swift
//  GalleryProject
//
//  Created by Juliya on 22.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation
import ObjectMapper

struct GalleryImage: Mappable {
    
    var imageURL: URL {
        return URL(string: "https://farm\(farmId).staticflickr.com/\(serverId)/\(id)_\(secret).jpg")!
    }
    
    var farmId:Int = 0
    var serverId:String = ""
    var id:String = ""
    var secret:String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        farmId <- map["farm"]
        serverId <- map["server"]
        id <- map["id"]
        secret <- map["secret"]
    }
}
