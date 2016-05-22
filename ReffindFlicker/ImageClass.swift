//
//  ImageClass.swift
//  ReffindFlicker
//
//  Created by Hajji on 21/05/2016.
//  Copyright © 2016 Hajji. All rights reserved.
//

import Foundation
import UIKit

class ImageClass: NSObject {
    
    // Lets define all the variable we need to recycle them thru the methods
    var imageUrl : NSURL!
    var flickerImage : UIImage! = nil
    var farm     = ""
    var server   = ""
    var photoID  = ""
    var secret   = ""
    var size     = ""
    
    
    func getImage(details: NSDictionary, imageSize: String, completionHandler:(result: UIImage) -> Void) {
        
        farm    = String(details.objectForKey("farm")!)
        server  = details.objectForKey("server") as! String
        photoID = details.objectForKey("id") as! String
        secret  = details.objectForKey("secret") as! String
        size    = imageSize
        
        imageUrl = NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")!

        self.queryImage(imageUrl, completion: { image, error in
            completionHandler(result: image)
        })
        print(imageUrl)
//        http://farm8.staticflickr.com/7579/27086100105_edc7a92306.jpg
    }
    
    
    func queryImage(url: NSURL, completion: (image:UIImage, error: NSError?) -> Void) {
        let loadRequest = NSURLRequest(URL:url)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(loadRequest, completionHandler: { data, response, error -> Void in
            
            var imageReturn: UIImage!
            if error != nil {
                imageReturn = nil;
            }
            
            if data != nil {
                imageReturn = UIImage(data:data!)
            }
            
            completion(image: imageReturn!, error: error)
            return
        })
        task.resume()
        return
    }
    
}