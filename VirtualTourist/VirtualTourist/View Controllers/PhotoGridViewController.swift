//
//  PhotoGridViewController.swift
//  VirtualTourist
//
//  Created by Tristan Pudell-Spatscheck on 5/25/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
var tempImage : UIImage?
import Foundation
import UIKit
import MapKit
class PhotoGridViewController:  UIViewController, UICollectionViewDelegate, MKMapViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets up mapView at top
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: pins[pinID].lat, longitude: pins[pinID].long)
        self.mapView.addAnnotation(annotation)
        locationZoom(with: CLLocationCoordinate2D(latitude: pins[pinID].lat, longitude: pins[pinID].long))
    }
    //function to show how many items are able to be viewed
    func numberOfItems(inSection section: Int) -> Int {
        return 30
    }
    //function to set up each cell of the collection view
    func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCell.identifier, for: indexPath) as! PhotoGridCell
        cell.imageView.image = nil
        cell.activityView.startAnimating()
        return cell
    }
    //zooms in on a location
    func locationZoom(with coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        self.mapView.isUserInteractionEnabled = false
        self.mapView.setRegion(region, animated: true)
    }
}
