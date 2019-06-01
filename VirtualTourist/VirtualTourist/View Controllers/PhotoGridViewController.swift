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
import CoreData
var allPhotos: [Photo] = []
class PhotoGridViewController:  UIViewController, UICollectionViewDelegate, MKMapViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets up mapView at top
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: pins[currentPinIndex].lat, longitude: pins[currentPinIndex].long)
        self.mapView.addAnnotation(annotation)
        locationZoom(with: CLLocationCoordinate2D(latitude: pins[currentPinIndex].lat, longitude: pins[currentPinIndex].long))
        //gets images
        APICommands().getPhotos(pin: pins[currentPinIndex])
        sleep(5)
        fetchPhotos(pin: pins[currentPinIndex])
        
    }
    //function to show how many items are able to be viewed
    func numberOfItems(inSection section: Int) -> Int {
        return 30
    }
    //function to set up each cell of the collection view
    func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCell.identifier, for: indexPath) as! PhotoGridCell
        print("LOADING")
        print(allPhotos[0].image!)
        cell.imageView.image = (UIImage(data: allPhotos[0].image!))
        cell.activityView.startAnimating()
        return cell
    }
    //fetches photos stored at given pin
    func fetchPhotos(pin: Pin) {
        var photos: [Photo]
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let predicate = NSPredicate(format: "pin == %@", pin)
        fetchRequest.predicate = predicate
        do {
            // get the data
            let result = try dataController.viewContext.fetch(fetchRequest)
            photos=result
            // put it on the map
            for photo in photos {
                //print("found",photo.imageUrl);
            }
            allPhotos = photos
            //print(allPhotos)
        } catch {
            return
        }
        
        
    }
    //zooms in on a location
    func locationZoom(with coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        self.mapView.isUserInteractionEnabled = false
        self.mapView.setRegion(region, animated: true)
    }
    //called when new collection is pressed
    @IBAction func newCollection(_ sender: Any) {
    }
}
