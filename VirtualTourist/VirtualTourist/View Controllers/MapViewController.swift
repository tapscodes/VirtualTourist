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
        mapView.delegate = self
        //adds long press scanner
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        //TEST VALUES FOR PINS+ANNOTATIONS (IN NYC)
        //tests zoom used in photogrid
        //locationZoom(with: CLLocationCoordinate2D(latitude: pins[0].lat, longitude: pins[0].long))
        APICommands().getPhotos(lat: 40, long: -74)
        APICommands().requestImage(farm: "6", secret: "8b816d7d81", ID: "20875765031", server: "5675")
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
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        for (index,pin) in pins.enumerated() {
            if(pin.lat == view.annotation!.coordinate.latitude) && (pin.long == view.annotation!.coordinate.longitude) {
                print ("Got it")
                print (index)
            }
        }
        //ADD PRESENT LATER (currently crashes app)
        //let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC")
        //self.present(vc, animated: true)
    }
    //func called when edit is tapped
    @IBAction func editTapped(_ sender: Any) {
        if(deleteWarning.isHidden == true){
        deleteWarning.isHidden = false
        }else{
        deleteWarning.isHidden = true
        }
    }
    //whats happens when a long hold is detected
    @objc func longTap(sender: UIGestureRecognizer){
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            //sets pin lat+long and adds it to pins array
            let pin = Pin(context: dataController.viewContext)
            pin.lat = locationOnMap.latitude
            pin.long = locationOnMap.longitude
            pins.append(pin)
            //adds pin to map
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.long)
            self.mapView.addAnnotation(annotation)
        }
    }
}
