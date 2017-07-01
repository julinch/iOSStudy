//
//  DataLoader.swift
//  GalleryGuide
//
//  Created by Juliya on 31.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation

extension Date {
    static func from(string: String?) -> Date?
    {
        guard let string = string
            else {
            return nil
        }
        let  dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.sss'Z'"
        return dateFormatter.date(from: string )
    }
}

//yyyy-MM-dd’T’hh:mm:ss.sss’Z’
