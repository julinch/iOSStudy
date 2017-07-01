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
    func openedEvents(in places: [Place]) -> [Event]
   
    func closingEvents(in places: [Place]) -> [Event]
    
    func openingEvents(in places: [Place]) -> [Event]
    
}




/*let calendar = NSCalendar.current


if calendar.isDateInToday(date) { return }*/

