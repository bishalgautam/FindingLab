//
//  PresentViewController.swift
//  FindingLab
//
//  Created by Bishal Gautam on 5/13/16.
//  Copyright © 2016 Bishal Gautam. All rights reserved.
//

import UIKit
import MapKit

class PresentViewController: UIViewController {
    
    

    @IBOutlet weak var mapView: MKMapView!
    
    
    var lat  : CLLocationDegrees = 0.0
    var long : CLLocationDegrees = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let initialLocation = CLLocation(latitude: lat, longitude: long)
        
        let regionRadius: CLLocationDistance = 100
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 3.0, regionRadius * 3.0)
            
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(initialLocation)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
