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
var pins : [Pin] = []
var photos: [Photo] = []
class MapViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var deleteWarning: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    //function called when view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.isUserInteractionEnabled = true
        deleteWarning.isUserInteractionEnabled = false
        deleteWarning.isHidden = true
        var annotations = [MKPointAnnotation]()
        let annotation = MKPointAnnotation()
        //TEST VALUES FOR PINS+ANNOTATIONS (IN NYC)
        //PINS STILL NOT FUNCTIONAL
        //var pin: Pin!
        //pin.lat = 40.7128
        //pin.long = -74.0060
        //pins.append(pin)
        //locationZoom(with: CLLocationCoordinate2D(latitude: pins[0].lat, longitude: pins[0].long))
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
        annotation.title = "worked"
        APICommands().getPhotos(lat: 40.7128, long: -74.0060)
        APICommands().requestImage(farm: "6", secret: "8b816d7d81", ID: "20875765031", server: "5675")
        annotations.append(annotation)
        self.mapView.removeAnnotations(self.mapView.annotations)
        sleep(1)
        print("Map Loading")
        self.mapView.addAnnotations(annotations)
        print(self.mapView.annotations)
    }
    //for function that makes pins
    /*let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
     let annotation = MKPointAnnotation()
     annotation.coordinate = coordinate
     annotations.append(annotation)
     */
    func locationZoom(with coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.isUserInteractionEnabled = true
        self.mapView.setRegion(region, animated: true)
    }
    //function called when a pin is tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC")
        present(vc, animated: true)
    }
    //func called when edit is tapped
    @IBAction func editTapped(_ sender: Any) {
        if(deleteWarning.isHidden == true){
        deleteWarning.isHidden = false
        }else{
        deleteWarning.isHidden = true
        }
    }
}
