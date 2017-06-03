//
//  Place.swift
//  GalleryGuide
//
//  Created by Juliya on 27.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation


class Place
{
    var adress: String = ""
    var website: URL?
    var liason = Person()
    var details: String = ""
    var logo: URL?
    var title: String = ""
    var events: [Event] = []
}
