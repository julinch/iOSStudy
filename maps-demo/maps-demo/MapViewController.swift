//
//  ViewController.swift
//  maps-demo
//
//  Created by Juliya on 20.07.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    var mapView: GMSMapView?
    var markerArray = [MapMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //temp struct fill
        var eventArray = [TripScheduledEvent]()
        var tripEvent = TripScheduledEvent(time: "10:00", latitude: 50.388573, longitude: 30.364974)
        eventArray.append(tripEvent)
        tripEvent = TripScheduledEvent(time: "12:00", latitude: 50.390755, longitude: 30.368890)
        eventArray.append(tripEvent)
        tripEvent = TripScheduledEvent(time: "14:00", latitude: 50.395082, longitude:  30.370599)
        eventArray.append(tripEvent)
        tripEvent = TripScheduledEvent(time: "16:00", latitude: 50.392259, longitude: 30.373192)
        eventArray.append(tripEvent)
        tripEvent = TripScheduledEvent(time: "18:00", latitude: 50.388422, longitude: 30.370306)
        eventArray.append(tripEvent)
        //
        
        
        GMSServices.provideAPIKey("AIzaSyBy-kEyskeG1aQ6gx66z7cCJG0FMfWe1VA")
        let camera = GMSCameraPosition.camera(withLatitude: eventArray[0].latitude, longitude: eventArray[0].longitude, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera )
        
        for i in eventArray {
            let marker = MapMarker(position: CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude), time: i.time, map: mapView!)
            markerArray.append(marker)
        
        }
        
        
        
        
        view = mapView
        
         mapView?.delegate = self
        
    }
    
    
//        let nextLocation = CLLocationCoordinate2D(latitude: 50.390755, longitude: 30.368890)
    
    
    //didTapInfoWindowOfMarker
     func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker ) {
        print("yes")
        
        

    }
    
     func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("yes")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
        self.present(nextViewController, animated:true, completion:nil)
        for markers in markerArray {
            if marker == markers.marker {
                nextViewController.label.text = markers.timeGl
            }
        }
        return true
    }

    
    
}

