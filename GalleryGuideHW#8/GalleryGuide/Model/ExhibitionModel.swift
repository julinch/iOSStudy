//
//  ExhibitionModel.swift
//  GalleryGuide
//
//  Created by Juliya on 06.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import Foundation
import UIKit

class ExhibitionsModel {
    
    let limit = 10
    var skip = 0
    var currentExhibitionFilterType: ExhibitionFilterType = .all {
        didSet {
            if currentExhibitionFilterType != oldValue {
                exhibitions = []
            }
        }
    }
    
    private(set)  var exhibitions: [ExhibitionVO] = []
    
    
    static var instance: ExhibitionsModel = ExhibitionsModel()
    
    func loadExhibitions(exhibitionsLoaded:@escaping () -> Void) {
        print(currentExhibitionFilterType)
        switch currentExhibitionFilterType {
        case .all:
            loadAllExhibitions(exhibitionsLoaded: exhibitionsLoaded)
        case .opening:
            loadOpeningExhibitions(exhibitionsLoaded: exhibitionsLoaded)
        case .lastChance:
            loadLastChanceExhibitions(exhibitionsLoaded: exhibitionsLoaded)
        case .popular:
            loadPopularExhibitions(exhibitionsLoaded: exhibitionsLoaded)
        case .nearMe:
            loadNearMeExhibitions(exhibitionsLoaded: exhibitionsLoaded)
        }
    }
    
    func loadAllExhibitions(exhibitionsLoaded:@escaping () -> Void) {
        let requestSender = RequestSender()
        requestSender.requestAllExhibitions(skip: skip, limit: limit, exhibitionsLoaded: exhibitionsLoaded)
    }
    
    func loadOpeningExhibitions(exhibitionsLoaded: @escaping () -> Void) {
        let requestSender = RequestSender()
        requestSender.requestOpeningExhibitions(skip: skip, limit: limit, exhibitionsLoaded: exhibitionsLoaded)
    }
    
    func loadLastChanceExhibitions(exhibitionsLoaded: @escaping () -> Void) {
        let requestSender = RequestSender()
        requestSender.requestLastChanceExhibitions(skip: skip, limit: limit, exhibitionsLoaded: exhibitionsLoaded)
    }
    
    func loadPopularExhibitions(exhibitionsLoaded: @escaping () -> Void) {
        let requestSender = RequestSender()
        requestSender.requestPopularExhibitions(skip: skip, limit: limit, exhibitionsLoaded: exhibitionsLoaded)
    }
    
    func loadNearMeExhibitions(exhibitionsLoaded: @escaping () -> Void) {
        let requestSender = RequestSender()
        requestSender.requestNearMeExhibitions(exhibitionsLoaded: exhibitionsLoaded)
    }
    
    
    
    
    func setExhibitions(exhibitions: [ExhibitionVO]) {
        self.exhibitions += exhibitions
        for exhibition in exhibitions {
            if let galleryName = exhibition.gallery?.name {
            print(galleryName)
            }
        }
    }
}



enum ExhibitionFilterType {
    case all
    case opening
    case lastChance
    case popular
    case nearMe
}

