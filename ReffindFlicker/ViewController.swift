//
//  ViewController.swift
//  ReffindFlicker
//
//  Created by Hajji on 18/05/2016.
//  Copyright © 2016 Hajji. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    let searchClass = SearchClass()

    @IBOutlet weak var searchField: UITextField!
    
    
    
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
        data.count;
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

