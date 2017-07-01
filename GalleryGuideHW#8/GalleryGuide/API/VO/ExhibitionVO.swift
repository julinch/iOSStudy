//
//  ExhibitionVO.swift
//  GalleryGuide
//
//  Created by Juliya on 31.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation
import ObjectMapper


struct ExhibitionVO {
    var id: String?
    var authorName: String?
    var name: String?
    var authorDescription: String?
    var about: String?
    
    var startDate: GetDateInfo?
    var endDate: GetDateInfo?
    var gallery: GalleryVO?
    var works: [WorkVO]?
    
    init(gallery: GalleryVO!, works:[WorkVO]?) {
        self.gallery = gallery
        self.works = works
    }
}


extension ExhibitionVO: Mappable {
    
    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        id <- map["objectId"]
        authorName <- map["authorName"]
        name <- map["name"]
        about <- map["about"]
        authorDescription <- map["authorDescription"]
        startDate <- map["dateStart"]
        endDate <- map["dateEnd"]
        gallery <- map["gallery"]
        works <- map["works"]
    }
    
}


struct GetDateInfo: Mappable {
    
    var iso: String?
    var isoDate: Date?
    var formattedDateString: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        iso <- map["iso"]
        
        isoDate = Date.from(string: iso)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.sss'Z'"
        formattedDateString = dateFormatter.string(from: isoDate!)
        formattedDateString = formattedDateString?.components(separatedBy: "T").first!
        formattedDateString = formattedDateString?.replacingOccurrences(of: "-", with: ".")
    }
    
    
}

