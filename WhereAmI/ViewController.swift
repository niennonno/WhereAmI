//
//  ViewController.swift
//  WhereAmI
//
//  Created by Aditya Vikram Godawat on 11/01/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
    var manager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        courseLabel.text = "\(userLocation.course)"
        speedLabel.text = "\(userLocation.speed)"
        altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            if (error != nil) {
            
                print(error)
            
            } else {
                
                if let p = placemarks?.first {
                    
                    var subThoroughfare = ""
                    
                    var thoroughfare = ""
                    
                    var subLocality = ""
                    
                    var subAdministrativeArea = ""
                    
                    if p.subThoroughfare != nil {
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    if p.thoroughfare != nil {
                        
                        thoroughfare = p.thoroughfare!
                        
                    }
                    
                    if p.subLocality != nil {
                        
                        subLocality = p.subLocality!
                        
                    }
                    
                    if p.subAdministrativeArea != nil {
                        
                        subAdministrativeArea = p.subAdministrativeArea!
                        
                    }
                    
                    self.addressLabel.text = "\(subThoroughfare)\n\(thoroughfare)\n\(subLocality)\n\(subAdministrativeArea)\n\(String(p.postalCode!))\n\(String(p.country!))"
                    
                }
                
//                if let p = placemarks?.first {
//                
//                    var subThoroughfare: String = ""
//                    print(p)
//                    print(p.thoroughfare)
//                    
//                    if(p.subThoroughfare != nil) {
//                        
//                        subThoroughfare = p.subThoroughfare!
//                        print(subThoroughfare)
//                        
//                    }
//                    
//                    self.addressLabel.text = " \(p.thoroughfare)\n \(p.subLocality) \(p.subAdministrativeArea)\n \(p.postalCode), \(p.country)"
//                }
                
            }

        }
        
    }
    
}

