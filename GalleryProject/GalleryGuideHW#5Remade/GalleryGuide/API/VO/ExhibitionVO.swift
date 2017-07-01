//
//  ExhibitionVO.swift
//  GalleryGuide
//
//  Created by Juliya on 31.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation


struct ExhibitionVO
{
    var id: String?
    var authorName: String?
    var name: String?
    var about: String?
    var authorDescription: String?
    var startDate: Date?
    var endDate: Date?
    var gallery: GalleryVO!
    var works: [WorkVO]!
    
    init(gallery: GalleryVO!, works:[WorkVO]!) {
        self.gallery = gallery
        self.works = works
    }
}

extension ExhibitionVO: Parsable {
    mutating func parse(json:[String: Any]) {
        
        self.id = json["_id"] as? String
        self.authorName = json["authorName"] as? String
        self.name = json["name"] as? String
        self.about = json["about"] as? String
        self.authorDescription = json["authorDescription"] as? String
        self.startDate = Date.from(string: json["dateStart"] as? String)
        self.endDate = Date.from(string: json["dateEnd"] as? String)
        
        
        
    }}

//authorName: exhibitionDictionary["authorName"] as? String,
//        name: exhibitionDictionary["name"] as! String,
//        about: exhibitionDictionary["about"] as? String,
//        authorDescription: exhibitionDictionary["authorDescription"] as? String,
//        startDate: Date.from(string: exhibitionDictionary["dateStart"] as? String),
//        endDate: Date.from(string: exhibitionDictionary["dateEnd"] as? String),
//        gallery: gallery,
