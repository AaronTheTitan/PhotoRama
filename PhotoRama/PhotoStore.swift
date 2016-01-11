//
//  PhotoStore.swift
//  PhotoRama
//
//  Created by Aaron Bradley on 1/11/16.
//  Copyright © 2016 AaronTheTitan. All rights reserved.
//

import Foundation

class PhotoStore {
  
  let session: NSURLSession = {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    return NSURLSession(configuration: config)
  }()
  
  
  func fetchRecentPhotos(completion completion: (PhotosResult) -> Void) {
    
    let url = FlickrAPI.recentPhotosURL()
    let request = NSURLRequest(URL: url)
    
    let task = session.dataTaskWithRequest(request) {
      (data, response, error) -> Void in
      
//      if let jsonData = data {
//        
//        do {
//          let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
//          print(jsonObject)
//        } catch let error {
//          print("Error creating JSON object: \(error)")
//        }
//        
//      } else if let requestError = error {
//        print("Error fetching recent photos: \(requestError)")
//        
//      } else {
//        print("Unexpected error with the request")
//      }
      
      
      let result = self.processRecentPhotosRequest(data: data, error: error)
      completion(result)
      
    }
    task.resume()
  }
  
  func processRecentPhotosRequest(data data: NSData?, error: NSError?) -> PhotosResult {
    guard let jsonData = data else {
      return .Failure(error!)
    }
    
    return FlickrAPI.photosfromJSONData(jsonData)
  }
  
  
}