//
//  PhotoGridViewController.swift
//  VirtualTourist
//
//  Created by Tristan Pudell-Spatscheck on 5/25/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class PhotoGridViewController: UICollectionView, MKMapViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    //function to show how many items are able to be viewed
    override func numberOfItems(inSection section: Int) -> Int {
        return 5
    }
    //function to set up each cell of the collection view
    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCell.identifier, for: indexPath) as! PhotoGridCell
        cell.imageView.image = nil
        cell.activityView.startAnimating()
        return cell
    }
}
