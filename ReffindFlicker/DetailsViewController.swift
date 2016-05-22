//
//  DetailsViewController.swift
//  ReffindFlicker
//
//  Created by Hajji on 21/05/2016.
//  Copyright © 2016 Hajji. All rights reserved.
//

import Foundation
import UIKit


class DetailsViewController: UIViewController {
    
    let imageClass  = ImageClass()
    
    var photoDetails : NSDictionary!
    
    @IBOutlet var imageContainer: UIView!
    @IBOutlet weak var fullImage: UIImageView!
    @IBOutlet weak var farm: UILabel!
    @IBOutlet weak var server: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet var photoID: UILabel!
    @IBOutlet var owner: UILabel!
    
    override func viewDidLoad() {
        print(photoDetails)
        self.fullImage.image = nil
        let loader = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        loader.center = fullImage.center
        loader.startAnimating()
        fullImage.addSubview(loader)
        
        imageClass.getImage(photoDetails, imageSize: "n", completionHandler: { result in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                    // Sets the image
                    self.fullImage.image = result
                
                    // Set the details
                    self.des.text =  self.photoDetails.objectForKey("title") as? String
                    self.farm.text =  String(self.photoDetails.objectForKey("farm")!)
                    self.photoID.text =  self.photoDetails.objectForKey("id") as? String
                    self.owner.text =  self.photoDetails.objectForKey("owner") as? String
                    self.server.text =  self.photoDetails.objectForKey("server") as? String
                
                })
            // Lets stop the loader and dispose
            loader.stopAnimating()
            loader.removeFromSuperview()
        })
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(false)
        print("Am gone!")
        
        
    }
    
}