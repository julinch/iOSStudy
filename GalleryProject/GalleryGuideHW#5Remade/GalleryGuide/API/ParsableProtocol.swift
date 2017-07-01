//
//  ParsableProtocol.swift
//  GalleryGuide
//
//  Created by Juliya on 06.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation

protocol  Parsable {
    mutating func parse(json: [String:Any])
}
