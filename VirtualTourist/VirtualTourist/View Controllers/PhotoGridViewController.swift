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
class PhotoGridViewController:  UIViewController, UICollectionViewDelegate, MKMapViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    var allPhotos: [Photo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets up mapView at top
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: pins[currentPinIndex].lat, longitude: pins[currentPinIndex].long)
        self.mapView.addAnnotation(annotation)
        locationZoom(with: CLLocationCoordinate2D(latitude: pins[currentPinIndex].lat, longitude: pins[currentPinIndex].long))
        //gets images
        loadImagesInClass(pin: pins[currentPinIndex])
        collectionView.reloadData()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PhotoGridCell.identifier)
    }
    //sets up collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCell.identifier, for: indexPath) as! PhotoGridCell
        print("LOADING")
        print(allPhotos[0].image!)
        cell.imageView.image = (UIImage(data: allPhotos[0].image!))
        cell.activityView.startAnimating()
        return cell
    }
    //checks if images have been loaded before
    func loadImagesInClass(pin: Pin) {
        allPhotos.removeAll()
        fetchPhotos(pin: pins[currentPinIndex])
        if (allPhotos.isEmpty) {
            print("Fetching NEW IMAGES")
            //gets images
            APICommands().getPhotos(pin: pins[currentPinIndex])
            sleep(5)
            fetchPhotos(pin: pins[currentPinIndex])
        } else {
            print("Images already available")
        }
    }
    //fetches photos stored at given pin
    func fetchPhotos(pin: Pin) {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let predicate = NSPredicate(format: "pin == %@", pin)
        fetchRequest.predicate = predicate
        do {
            // get the data
            let result = try dataController.viewContext.fetch(fetchRequest)
            allPhotos=result
            // put it on the map
            for photo in allPhotos {
                //print("found",photo.imageUrl);
            }
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
