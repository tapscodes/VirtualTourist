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
        self.mapView.isUserInteractionEnabled = true
        deleteWarning.isUserInteractionEnabled = false
        deleteWarning.isHidden = true
        var annotations = [MKPointAnnotation]()
        let annotation = MKPointAnnotation()
        //TEST VALUES FOR PINS+ANNOTATIONS (IN NYC)
        let pin = Pin(context: dataController.viewContext)
        pin.lat = 40.7128
        pin.long = -74.0060
        pins.append(pin)
        //tests zoom used in photogrid
        //locationZoom(with: CLLocationCoordinate2D(latitude: pins[0].lat, longitude: pins[0].long))
        annotation.coordinate = CLLocationCoordinate2D(latitude: pins[0].lat, longitude: pins[0].long)
        APICommands().getPhotos(lat: pins[0].lat, long: pins[0].long)
        APICommands().requestImage(farm: "6", secret: "8b816d7d81", ID: "20875765031", server: "5675")
        annotations.append(annotation)
        self.mapView.removeAnnotations(self.mapView.annotations)
        sleep(1)
        print("Map Loading")
        self.mapView.addAnnotations(annotations)
        print(self.mapView.annotations)
    }
    //zooms in on a location, used in PhotoGridVC
    func locationZoom(with coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.isUserInteractionEnabled = false
        self.mapView.setRegion(region, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let reuseId = "pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = false
                pinView!.pinTintColor = .red
            }
            else {
                pinView!.annotation = annotation
            }
            return pinView
        }
    //functionc alled when pin is tapped
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
