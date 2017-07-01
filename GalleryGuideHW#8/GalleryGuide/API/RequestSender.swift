//
//  RequestSender.swift
//  GalleryGuide
//
//  Created by Juliya on 22.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation
import SDWebImage
import Alamofire
import AlamofireObjectMapper


class RequestSender {
    func requestOpeningExhibitions(skip: Int, limit: Int, exhibitionsLoaded:@escaping () -> Void) {
        let params = [
            "skip" : skip,
            "limit" : limit
        ]

        Alamofire.request("https://gallery-guru-prod.herokuapp.com/exhibitions/opening", parameters: params).responseArray {
            (response: DataResponse<[ExhibitionVO]>) in
            
            switch response.result {
            case .success(let result):
                ExhibitionsModel.instance.setExhibitions(exhibitions: result)
                
                exhibitionsLoaded()
                
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
        
        
    func requestAllExhibitions(skip: Int, limit: Int, exhibitionsLoaded:@escaping () -> Void) {
        
        let params = [
            "skip" : skip,
            "limit" : limit
        ]
        
        
        Alamofire.request("https://gallery-guru-prod.herokuapp.com/exhibitions", parameters: params).responseArray {
            (response: DataResponse<[ExhibitionVO]>) in
            
            switch response.result {
            case .success(let result):
                
                
                ExhibitionsModel.instance.setExhibitions(exhibitions: result)
                
                exhibitionsLoaded()
                
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }

    func requestLastChanceExhibitions(skip: Int, limit: Int, exhibitionsLoaded:@escaping () -> Void) {
        let params = [
            "skip" : skip,
            "limit" : limit
        ]

        Alamofire.request("https://gallery-guru-prod.herokuapp.com/exhibitions/lastchance", parameters: params).responseArray {
            (response: DataResponse<[ExhibitionVO]>) in
            
            switch response.result {
            case .success(let result):
                ExhibitionsModel.instance.setExhibitions(exhibitions: result)
                exhibitionsLoaded()
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }

    func requestPopularExhibitions(skip: Int, limit: Int, exhibitionsLoaded:@escaping () -> Void) {
        let params = [
            "skip" : skip,
            "limit" : limit
        ]

        Alamofire.request("https://gallery-guru-prod.herokuapp.com/exhibitions/popular", parameters: params).responseArray {
            (response: DataResponse<[ExhibitionVO]>) in
            
            switch response.result {
            case .success(let result):
                ExhibitionsModel.instance.setExhibitions(exhibitions: result)
                exhibitionsLoaded()
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }

    
    func requestNearMeExhibitions(exhibitionsLoaded:@escaping () -> Void) {
        Alamofire.request("https://gallery-guru-prod.herokuapp.com/exhibitions/near").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
    
    func loadExhibition(id: String, exhibitionLoaded:@escaping (ExhibitionVO) -> Void) {
        let query = "https://gallery-guru-prod.herokuapp.com/exhibitions/" + id
        Alamofire.request(query).responseArray {
            (response: DataResponse<[ExhibitionVO]>) in
            
            switch response.result {
            case .success(let result):
                
                exhibitionLoaded(result[0])
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }

        
    }

}


/*switch response.result {
 case .success(let images):
 self?.images = images
 self?.tableView.reloadData()
 case .failure(let error):
 print("Error: \(error)")
 }
*/
