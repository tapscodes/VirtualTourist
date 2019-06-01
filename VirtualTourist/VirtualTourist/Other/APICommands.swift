//
//  APICommands.swift
//  VirtualTourist
//
//  Created by Tristan Pudell-Spatscheck on 5/27/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import UIKit
import Foundation

class APICommands{
    //NOT ACTUALLY USED, JUST HERE FOR ME TO BE ABLE TO EASILY RETURN TO DOCUMENTATION
    let geoDocumentation = "https://www.flickr.com/services/api/flickr.photos.geo.photosForLocation.html"
    //THIS IS WHERE YOU PUT YOUR API KEY (this one is fake so noone can overload requests)
    let apiKey = "8980acc92ce4a6549c9dd4a144685ec2"
    let webURL = "https://api.flickr.com"
    let methodHead = "/services/rest/?method="
    let getPhoto = "flickr.photos.search"
    //gets 30 photos at given lat+long
    func getPhotos(pin: Pin){
        let lat = pin.lat
        let long = pin.long
        let urlString = "\(webURL)\(methodHead)\(getPhoto)&api_key=\(apiKey)&accuracy=15&has_geo=1&lat=\(lat)&lon=\(long)&per_page=30&page=1&format=json&nojsoncallback=1"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error
                return
            }
            //print(String(data: data!, encoding: .utf8)!)
            do{
                let decoder = JSONDecoder()
                var imgResponse: ImgResponse
                imgResponse = try decoder.decode(ImgResponse.self, from: data!)
                if (imgResponse.photos.total == "0") {
                    /// XXX no images let user know
                } else {
                    for (index,photo) in imgResponse.photos.photo!.enumerated() {
                        self.requestImage(index: index, pin: pin, farm: photo.farm!, secret: photo.secret!, ID: photo.ID!, server: photo.server!)
                    }
                }
                
            }
            catch{
                print(error)
                // XXX Do something to tell user there is an issue
            }
        }
        task.resume()
    }
    //changes tempImage to the requested image
    func requestImage(index: Int, pin: Pin, farm: Int, secret: String, ID: String, server:String){
        let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(ID)_\(secret).jpg"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let persistentPhoto = Photo(context: dataController.viewContext)
        persistentPhoto.image=nil
        persistentPhoto.imageUrl=urlString
        persistentPhoto.pin=pin
        do {
            try dataController.viewContext.save()
        } catch {
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error
                return
            }
            //CANT BE PRINTED BECAUSE ITS AN IMAGE
            //print(String(data: data!, encoding: .utf8)!)
            persistentPhoto.image=data!
            do {
                try dataController.viewContext.save()
            } catch {
            }
            //print("DONE LOADING IMAGE ", urlString)
        }
        task.resume()
    }
}
