//
//  GalleryVO.swift
//  GalleryGuide
//
//  Created by Juliya on 31.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation



struct GalleryVO {
    var id: String!
    var name: String!
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

extension GalleryVO: Parsable {
    mutating func parse(json: [String : Any]) {
        self.id = json["_id"] as! String
        self.name = json["name"] as! String
        self.galleryDescription = json["galleryDescription"] as? String
        self.email = json["email"] as? String
        self.facebook = json["facebook"] as? String
        self.city = json["city"] as? String
        self.schedule = json["schedule"] as? String
        self.address = json["address"] as? String
        self.galleryLogo = json["galleryLogo"] as? String
        self.link = json["link"] as? String
        self.phone = json["phone"] as? String
        self.latitude = json["latitude"] as? Double
        self.longitude = json["longitude"] as? Double
        
    }
}
