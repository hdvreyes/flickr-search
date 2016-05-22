//
//  ViewController.swift
//  ReffindFlicker
//
//  Created by Hajji on 18/05/2016.
//  Copyright © 2016 Hajji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let searchClass           = SearchClass()
    let imageClass            = ImageClass()
    let detailsViewController = DetailsViewController()
    
    let cellIdentifier  = "CellIdentifier"
    var numberOfRows: Int = 0;
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    
    var imageArray: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func searchBtnAction(sender: AnyObject) {
        
        let searchValue = self.searchField.text!
        
        if !searchValue.isEmpty {
            //self.searchFlickr(searchValue)
//            let g = searchClass.search(searchValue)
            
//            print(g)
            self.searchClass.search(searchValue, completionHandler: { result in
                //print("hello -> \(result)");
                self.loadTableData(result)
            })
            
        }else{
            print("Empty")
        }
        
    }

    
    func loadTableData(data: NSArray){
        self.imageArray   = data
        //print(imageArray.objectAtIndex(0))
        self.numberOfRows =  data.count
        print(self.numberOfRows)
        //self.tableView.reloadData()
        
        // Let's reload the table shall we?
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath : indexPath) as UITableViewCell
        //let cell = self.tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        let searchInfo = imageArray.objectAtIndex(indexPath.row) as! NSDictionary
        
        // Placeholder
        cell.imageView?.image = UIImage(named: "loading-panda")
        
        self.imageClass.getImage(searchInfo, imageSize: "q", completionHandler: { result in
            // We need to dispatch cell loader to main queue, this will avoid hanging
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.imageView?.image = result
                cell.setNeedsLayout()
            })
        })
        
        print(searchInfo)
        
        // Now lets display the title on the cell
        cell.textLabel!.text = searchInfo.objectForKey("title") as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let storyboard = UIStoryboard(name: "Details", bundle: nil)

        //let controller = storyboard.instantiateViewControllerWithIdentifier("DetailViewIdentifier")
        
        //let board = UIStoryboard.instantiateViewControllerWithIdentifier("") as! self.navigationController
        
        
        //self.navigationController?.pushViewController(controller, animated: false);
        // Lets pass all the details
        //detailsViewController.photoDetails = imageArray.objectAtIndex(indexPath.row) as! NSDictionary
        //print(imageArray.objectAtIndex(indexPath.row))
        //detailsViewController.test = "test"
        //let next = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewIdentifier")
        
       // self.presentViewController(next!, animated: false, completion: nil)
        //self.navigationController!.pushViewController(next, animated: true);
        
        //let destination = UIViewController() // Your destination
        //self.navigationController?.pushViewController(detailsViewController, animated: true)
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("DetailViewIdentifier") as! DetailsViewController
        destination.photoDetails = imageArray.objectAtIndex(indexPath.row) as! NSDictionary
        navigationController?.pushViewController(destination, animated: true)

        
    }
    
    func searchFlickr(param: String)->AnyObject{
        let data : AnyObject! = ""
        
        print(param)
        return data
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

