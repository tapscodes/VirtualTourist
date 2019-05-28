//
//  APICommands.swift
//  VirtualTourist
//
//  Created by Tristan Pudell-Spatscheck on 5/27/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
class APICommands{
   //NOT ACTUALLY USED, JUST HERE FOR ME TO BE ABLE TO EASILY RETURN TO DOCUMENTATION
   let geoDocumentation = "https://www.flickr.com/services/api/flickr.photos.geo.photosForLocation.html"
   //THIS IS WHERE YOU PUT YOUR API KEY (this one is fake so noone can overload requests)
   let apiKey = "PUT API KEY HERE"
   let webURL = "https://api.flickr.com"
   let methodHead = "/services/rest/?method="
   let getPhoto = "flickr.photos.geo.photosForLocation"
    func getPhotos(lat: Float ,long: Float){
        let urlString = "\(webURL)\(methodHead)\(getPhoto)&api_key=\(apiKey)&lat=\(lat)&lon=\(long)&format=rest"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error
            return
            }
             print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}
