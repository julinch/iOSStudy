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
    var name: String
    var about: String?
    var authorDescription: String?
    var startDate: Date?
    var endDate: Date?
    var gallery: GalleryVO!
}

