//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by Tristan Pudell-Spatscheck on 5/25/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import Foundation
import MapKit
import UIKit
class MapViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var deleteWarning: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    //function called when view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteWarning.isUserInteractionEnabled = false
        deleteWarning.isHidden = true
        var annotations = [MKPointAnnotation]()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 100, longitude: 100)
        annotations.append(annotation)
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(annotations)
    }
    //for function that makes pins
    /*let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
     let annotation = MKPointAnnotation()
     annotation.coordinate = coordinate
     annotations.append(annotation)
     */
    //function called when a pin is tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC")
        present(vc, animated: true)
    }
    @IBAction func editTapped(_ sender: Any) {
        if(deleteWarning.isHidden == true){
        deleteWarning.isHidden = false
        }else{
        deleteWarning.isHidden = true
        }
    }
}
