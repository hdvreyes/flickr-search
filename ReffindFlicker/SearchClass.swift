//
//  SearchClass.swift
//  ReffindFlicker
//
//  Created by Hajji on 18/05/2016.
//  Copyright © 2016 Hajji. All rights reserved.
//

import Foundation

let key         = "cafcad0cc18648c2739dfcd329c52494"
let secret      = "776a0450b5509836"
let imageClass  = ImageClass()

class SearchClass: NSObject {
    
    func search(param: String, completionHandler: (result: NSArray) -> Void) {
        
        let paramEncode = param.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        
        let flickerUrl = NSURL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&text=\(paramEncode)&per_page=50&format=json&nojsoncallback=1")!
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: flickerUrl), completionHandler: { data, response, error -> Void in
            
            let photos: NSDictionary
            let stripped: NSArray
            
            do {
                photos = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            } catch  {
                print("No Data!")
                return
            }
            stripped = photos.objectForKey("photos")!.objectForKey("photo")! as! NSArray
            completionHandler(result: stripped)
            return
        })
        task.resume();
        
        return
        
    }
    
    func queryUrl(flickerUrl: NSURL, completionHandler: (result: NSArray) -> Void) {
       
        let task = NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: flickerUrl), completionHandler: { data, response, error -> Void in
            //print("\(response)\(error)")
            
            //let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            let photos: NSDictionary
            let stripped: NSArray
            
            do {
                photos = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            } catch  {
                print("error parsing response from POST on /categories")
                return
            }
            //print(photos.objectForKey("photos")?.objectForKey("photo")!)
            stripped = photos.objectForKey("photos")!.objectForKey("photo")! as! NSArray
            completionHandler(result: stripped)
            return
        })
        task.resume();
    }
    
}
