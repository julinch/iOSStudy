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
        dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ssZ"
        return dateFormatter.date(from: string )
    }
}




class DataLoader {
    
    func loadJson(name : String) -> [[String: Any]]?  {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "json")
            else {
                return nil
        }
        
        guard let exhibitionsRawData = try? Data(contentsOf: url)
            else {
                return nil
        }
        
        guard let exhibitionsRawArray = try? JSONSerialization.jsonObject(with: exhibitionsRawData) as? [[String: Any]]
            else {
                return nil
        }
        
        return exhibitionsRawArray
        
    }

    func loadExhibitions()  -> [ExhibitionVO]
    {
        let galleries = loadGalleries()
        
        let works = loadWorks()
        
        var result : [ExhibitionVO] = []
        
        
        if let array = loadJson(name: "exhibitions"){
            
        for exhibitionDictionary in array {
            
            var galleryID: String = exhibitionDictionary["_p_gallery"] as! String
            galleryID = galleryID.components(separatedBy: "$").last!
            
            if let gallery = galleries[galleryID] {
                
                var worksVO = [WorkVO]()
                if let exhibitionWorks = exhibitionDictionary["works"]{
                     var workIDs = [String]()
                    
                for work in exhibitionWorks as! [[String:String]] {
                    workIDs.append(work["objectId"]!)
                }
               
                for workID in workIDs {
                    if let work = works[workID] {
                        worksVO.append(work)
                        }
                    }
                }
                    
                var exhibition = ExhibitionVO(
                    gallery: gallery,
                    works: worksVO)
                
                exhibition.parse(json: exhibitionDictionary)
                
                result.append(exhibition)
                }
            }
        }
        
        return result
    }
    
    private func loadGalleries() -> [String: GalleryVO]
    {
        var result : [String: GalleryVO] = [:]
        
        if let array = loadJson(name: "galleries"){
            
            for galleryDictionary in array {
                
                var gallery = GalleryVO()
                gallery.parse(json: galleryDictionary)
                
                
                result[gallery.id] = gallery
            }
        }
        
        return result

    }
    
    
    private func loadWorks() -> [String: WorkVO]
    {
        var result : [String: WorkVO] = [:]
        
        
        if let array = loadJson(name: "works"){
            
            for workDictionary in array {
                
                var work = WorkVO()
                work.parse(json: workDictionary)
                
                result[work.id] = work
               
            }
        }
        
        return result
        
    }

    
    
}











