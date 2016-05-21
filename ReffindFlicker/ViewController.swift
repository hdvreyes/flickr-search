//
//  ViewController.swift
//  ReffindFlicker
//
//  Created by Hajji on 18/05/2016.
//  Copyright © 2016 Hajji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let searchClass     = SearchClass()
    let imageClass      = ImageClass()
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
        
        self.imageClass.getThumbnailImage(searchInfo, completionHandler: { result in
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
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
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

