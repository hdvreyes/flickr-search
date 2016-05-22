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
    
    override func viewDidLoad() {
        print(photoDetails)
        self.fullImage.image = nil
        let loader = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        loader.center = fullImage.center
        loader.startAnimating()
        fullImage.addSubview(loader)
        
        imageClass.getImage(photoDetails, imageSize: "n", completionHandler: { result in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.fullImage.image = result
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