//
//  DataLoader.swift
//  GalleryGuide
//
//  Created by Juliya on 31.05.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation

extension Date {
    static func from(string:String?) -> Date?
    {
        guard let string = string
            else {
            return nil
        }
        let  dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ssZ"
        return dateFormatter.date(from: string )
    }
}
class DataLoader {
    
    func loadExhibitions()  -> [ExhibitionVO]
    {
        let galleries = loadGalleries()
        
        var result : [ExhibitionVO] = []
        
        guard let url = Bundle.main.url(forResource: "exhibitions", withExtension: "json")
            else
                {
                    return result
                }
        
        guard let exhibitionsRawData = try? Data(contentsOf: url)
            else
                {
                    return result
                }
        
        guard let exhibitionsRawArray = try? JSONSerialization.jsonObject(with: exhibitionsRawData) as? [[String: Any]]
            else
                {
                    return result
                }
        
        if let array = exhibitionsRawArray{
            
        for exhibitionDictionary in array {
            
            var galleryID: String = exhibitionDictionary["_p_gallery"] as! String
            galleryID = galleryID.components(separatedBy: "$").last!
            if let gallery = galleryID {
            let exhibition = ExhibitionVO(
                id: exhibitionDictionary["_id"] as? String,
                authorName: exhibitionDictionary["authorName"] as? String,
                name: exhibitionDictionary["name"] as! String,
                about: exhibitionDictionary["about"] as? String,
                authorDescription: exhibitionDictionary["authorDescription"] as? String,
                startDate: Date.from(string: exhibitionDictionary["dateStart"] as? String),
                endDate: Date.from(string: exhibitionDictionary["dateEnd"] as? String),
                gallery: galleries[galleryID]!)
            
            
                result.append(exhibition)
            }
            }}
        
        return result
    }
    
    private func loadGalleries() -> [String: GalleryVO]
    {
        var result : [String: GalleryVO] = [:]
        
        guard let url = Bundle.main.url(forResource: "galleries", withExtension: "json")
            else
        {
            return result
        }
        
        guard let galleriesRawData = try? Data(contentsOf: url)
            else
        {
            return result
        }
        
        guard let galleriesRawArray = try? JSONSerialization.jsonObject(with: galleriesRawData) as? [[String: Any]]
            else
        {
            return result
        }
        
        if let array = galleriesRawArray{
            
            for galleryDictionary in array {
                
                let gallery = GalleryVO(
                id: galleryDictionary["_id"] as! String,
                name: galleryDictionary["name"] as! String,
                galleryDescription: galleryDictionary["galleryDescription"] as? String,
                email: galleryDictionary["email"] as? String,
                facebook: galleryDictionary["facebook"] as? String,
                city: galleryDictionary["city"] as? String
                )
                
                
                result[gallery.id] = gallery
            }
        }
        
        return result

    }
    
    
    
}











