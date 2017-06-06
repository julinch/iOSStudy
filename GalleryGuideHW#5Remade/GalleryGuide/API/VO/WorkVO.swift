//
//  WorkVO.swift
//  GalleryGuide
//
//  Created by Juliya on 03.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation

struct WorkVO {
    var id: String!
    var author: String?
    var imgPicture: String?
    var size: String?
    var title: String?
    var type: String?
    var year: Int?
    
}


extension WorkVO: Parsable {
    mutating func parse(json: [String : Any]) {
        self.id = json["_id"] as! String
        self.author = json["author"] as? String
        self.imgPicture = json["imgPicture"] as? String
        self.size = json["size"] as? String
        self.title = json["title"] as? String
        self.type = json["type"] as? String
        self.year = json["year"] as? Int
        
    }
}
