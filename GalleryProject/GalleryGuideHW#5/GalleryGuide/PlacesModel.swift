//
//  PlacesModel.swift
//  GalleryGuide
//
//  Created by Juliya on 27.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation


let timeIntervalWeek = 604800.0
let timeIntervalMonth = 2628002.0


class PlacesModel
{
    var places: [Place] = []
    
}


extension PlacesModel: EventModel
{
    func openedEvents() -> [Event]
    {
        
        let calendar = NSCalendar.current
        var events = [Event]()
        var todayEvents = [Event]()
        for place in self.places
        {
            events += place.events
        }
        for event in events
        {
            if calendar.isDateInToday(event.startDate)
            {
                todayEvents.append(event)
            }
        }
        return todayEvents
    }
    func closingEvents() -> [Event]
    {
       
        let date = Date()
        var events = [Event]()
        var weekEvents = [Event]()
        for place in self.places
        {
            events += place.events
        }
        for event in events
        {
            if date.timeIntervalSince(event.startDate) <= timeIntervalWeek
            {
                weekEvents.append(event)
            }
        }
        return weekEvents
    
    }
    func openingEvents() -> [Event]
    {
        let date = Date()
        var events = [Event]()
        var monthEvents = [Event]()
        for place in self.places
        {
            events += place.events
        }
        for event in events
        {
            if date.timeIntervalSince(event.startDate) <= timeIntervalMonth
            {
                monthEvents.append(event)
            }
        }
        return monthEvents
    }

}






