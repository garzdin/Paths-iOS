//
//  ViewController.swift
//  Paths
//
//  Created by Teodor on 13/11/2016.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet var mapView: MGLMapView!
    
    var object: Path? {
        didSet {
            if let object = object {
                if let pois = object.pois {
                    for poi in pois {
                        let marker = MGLPointAnnotation()
                        marker.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(poi.latitude), longitude: CLLocationDegrees(poi.longitude))
                        marker.title = poi.name
                        if let _ = view {
                            self.mapView.addAnnotation(marker)
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}

