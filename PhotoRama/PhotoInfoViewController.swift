//
//  PhotoInfoViewController.swift
//  PhotoRama
//
//  Created by Aaron Bradley on 1/12/16.
//  Copyright © 2016 AaronTheTitan. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {

  @IBOutlet var imageview: UIImageView!
  
  
  var photo: Photo! {
    didSet {
      navigationItem.title = photo.title
    }
  }
  
  var store: PhotoStore!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    store.fetchImageForPhoto(photo) { (result) -> Void in
      switch result {
      case let .Success(image):
        NSOperationQueue.mainQueue().addOperationWithBlock() {
          self.imageview.image = image
        }
      case let .Failure(error):
        print("Error fetching image for photo: \(error)")
      }
    }
  }
  
}
