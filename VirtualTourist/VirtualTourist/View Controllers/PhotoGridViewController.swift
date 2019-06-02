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
    }
    //sets up collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //print("LOADING")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGridCell", for: indexPath) as! PhotoGridCell
        cell.activityView.hidesWhenStopped = true
        cell.activityView.startAnimating()
        if let img = allPhotos[indexPath.row].image {
             cell.imageView.image = UIImage(data: img)
            cell.activityView.stopAnimating()
        } else {
            cell.imageView.image = UIImage(named: "black")
        }
        return cell
    }
    //deletes cell when clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rmPhoto: Photo
        print("delete photo: ", indexPath.row)
        rmPhoto = allPhotos[indexPath.row]
        allPhotos.remove(at: indexPath.row)
        do { // remove it from persisten storage and save.
            dataController.viewContext.delete(rmPhoto)
            try dataController.viewContext.save()
        } catch {
            return
        }
        collectionView.reloadData()
    }
    func refreshTillAllLoaded() {
        var has_nil: Bool = true
        while ( has_nil ) {
            if (!allPhotos.isEmpty)
            {
                has_nil = false
            }
            for photo in allPhotos {
                if let img = photo.image {
                } else {
                    has_nil = true
                }
            }
            sleep(1)
                DispatchQueue.main.async {
                self.fetchPhotos(pin: pins[currentPinIndex])
                self.collectionView.reloadData()
                do {
                    try dataController.viewContext.save()
                } catch {
                }
            }
        }
    }
    //checks if images have been loaded before
    func loadImagesInClass(pin: Pin) {
        allPhotos.removeAll()
        fetchPhotos(pin: pins[currentPinIndex])
        if (allPhotos.isEmpty) {
            APICommands().getPhotos(pin: pins[currentPinIndex])
            let dispatchQueue = DispatchQueue(label: "CheckingForDownloads", qos: .background)
            dispatchQueue.async{
                self.refreshTillAllLoaded()
            }
        } else {
            collectionView.reloadData()
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
        } catch {
            allPhotos.removeAll()
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
        let rmPhoto: Photo
        for photo in allPhotos {
            dataController.viewContext.delete(photo)
        }
        allPhotos.removeAll()
        do { // remove it from persisten storage and save.
            try dataController.viewContext.save()
        } catch {
            return
        }
        loadImagesInClass(pin: pins[currentPinIndex])
        collectionView.reloadData()
    }
}
