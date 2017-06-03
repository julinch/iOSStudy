//
//  EvaentsModel.swift
//  GalleryGuide
//
//  Created by Juliya on 27.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation

protocol EventModel
{
    func openedEvents() -> [Event]
   
    func closingEvents() -> [Event]
    
    func openingEvents() -> [Event]
    
}

