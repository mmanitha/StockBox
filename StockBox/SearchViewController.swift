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

    @IBOutlet weak var mainTable: UITableView!
    
    var StockLibrary : [StockEntry]? = [StockEntry]()
    
//    var testLibrary = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.StockLibrary = DataManager.sharedManager.getLibrary()
//        self.testLibrary = DataManager.sharedManager.getEntries()
        
        self.mainTable.dataSource = self
        self.mainTable.delegate = self
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(entryChangedFunction), name: "ENTRY_CHANGED", object: nil)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onNewEntryAdded), name: "ENTRY_ADDED", object: nil)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onEntryDeleted), name: "ENTRY_DELETED", object: nil)
        
    }
    
    
//    @objc func entryChangedFunction(msg:NSNotification) {
//        
//        if let userInfo = msg.userInfo as? [String : Bool] {
//            if userInfo["message"] == true {
//                
//                self.StockLibrary = DataManager.sharedManager.getEntries()
//                self.mainTable.reloadData()
//            }
//        }
//    }
//    
//    @objc func onNewEntryAdded(msg:NSNotification) {
//        
//        if let userInfo = msg.userInfo as? [String : Bool] {
//            if userInfo["message"] == true {
//                
//                self.StockLibrary = DataManager.sharedManager.getEntries()
//                self.mainTable.reloadData()
//            }
//        }
//        
//    }
//    
//    @objc func onEntryDeleted(msg: NSNotification) {
//        
//        if let userInfo = msg.userInfo as? [String : Bool] {
//            if userInfo["message"] == true {
//                
//                self.StockLibrary = DataManager.sharedManager.getEntries()
//                self.mainTable.reloadData()
//            }
//        }
//    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//TABLE FUNCTIONS
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return testLibrary.count
        
        if let x = StockLibrary {
            
            return x.count
        } else {
            
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        
//        let x = indexPath.row
//        cell.textLabel?.text = testLibrary[x]

        if let x = StockLibrary {
            
            cell.textLabel?.text = x[indexPath.row].stockNumber
        }
        
        return cell
    }

}

