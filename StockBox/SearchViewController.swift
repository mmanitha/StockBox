//
//  FirstViewController.swift
//  StockBox
//
//  Created by Michael Manisa on 8/22/16.
//  Copyright © 2016 Michael Manisa. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var StockLibrary : [StockEntry]? = [StockEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.StockLibrary = DataManager.sharedManager.getLibrary()
        
        self.mainTable.dataSource = self
        self.mainTable.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(entryChangedFunction), name: "ENTRY_CHANGED", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onNewEntryAdded), name: "ENTRY_ADDED", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onEntryDeleted), name: "ENTRY_DELETED", object: nil)
        
        //this code below is making things wonky
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
    }
    
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //NOTIFICATION FUNCTIONS
    
    @objc func entryChangedFunction(msg:NSNotification) {
        
        if let userInfo = msg.userInfo as? [String : Bool] {
            if userInfo["message"] == true {
                
                self.StockLibrary = DataManager.sharedManager.getLibrary()
                self.mainTable.reloadData()
            }
        }
    }
    
    @objc func onNewEntryAdded(msg:NSNotification) {
        
        if let userInfo = msg.userInfo as? [String : Bool] {
            if userInfo["message"] == true {
                
                self.StockLibrary = DataManager.sharedManager.getLibrary()
                self.mainTable.reloadData()
            }
        }
        
    }
    
    @objc func onEntryDeleted(msg: NSNotification) {
        
        if let userInfo = msg.userInfo as? [String : Bool] {
            if userInfo["message"] == true {
                
                self.StockLibrary = DataManager.sharedManager.getLibrary()
                self.mainTable.reloadData()
            }
        }
    }
    
    
    
    //SEARCH FUNCTIONS HERE
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func searchButton(sender: UIButton) {
        
        self.StockLibrary = DataManager.sharedManager.getLibrary()

        
        if (searchField.text == "") {
            
            self.StockLibrary = DataManager.sharedManager.getLibrary()
            self.mainTable.reloadData()
            
        } else if (searchField.text != nil) {
            
            let searchItem = searchField.text
            if let si = searchItem {
                DataManager.sharedManager.search(si)
            }
            self.StockLibrary = DataManager.sharedManager.getLibraryAfterSearch()
            self.mainTable.reloadData()
            
        }
        
    }
    
    
    
    //TABLE ELEMENTS HERE
    
    @IBOutlet weak var mainTable: UITableView!
    
    
    var sendContact : Int?
    
    
    
    
    
    
    
    
    
    
    //TABLE FUNCTIONS
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let x = StockLibrary {
            
            return x.count
        } else {
            
            return 0
        }
    }
    
    //something funky going on here... when i added this, it made all photos change
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCellTableViewCell
        
        cell.imageThumbView.image = nil
        
        if let x = StockLibrary {
            
            cell.stockNumberLabel.text = x[indexPath.row].stockNumber
            cell.clientNameLabel.text = x[indexPath.row].clientName
            
            var img : UIImage?
            if let y = x[indexPath.row].thumbnailReference {
                img = DataManager.sharedManager.loadImage(y)
            }
            cell.imageThumbView.image = img
            
        }
        
        return cell
    }
    
    
    
    //push data to the next VC
    
    //tableView Delegate Code
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        sendContact = indexPath.row
        
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    //push content
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let index = sendContact {
            if let NextVC = segue.destinationViewController as? DetailViewController {
                if let x = StockLibrary {
                    NextVC.recievedEntry = x[index]
                }
            }
        }
        print(StockLibrary)
    }
    
    
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        print("Returned from detail screen")
    }
    
    
}

