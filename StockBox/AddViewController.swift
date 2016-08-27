//
//  AddViewController.swift
//  StockBox
//
//  Created by Michael Manisa on 8/22/16.
//  Copyright © 2016 Michael Manisa. All rights reserved.
//

//  This VC is for loading or modifying entries

import UIKit
import CoreData


class AddViewController: UIViewController {

    var recievedEntry : StockEntry?
    
    @IBOutlet weak var imageField: UITextField!
    @IBOutlet weak var stockNumber: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var taskNumber: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IF entries were pushed in, fill fields with information:
        if let x = recievedEntry {
            imageField.text = x.imageReference
            stockNumber.text = x.stockNumber
            website.text = x.website
            clientName.text = x.clientName
            taskNumber.text = x.projectNumber
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//ADD/UPDATE ENTRY
    
    func addEntry() {
        

        
    }
    
    
    
    
//DELETE ENTRY
    
    func deleteEntry(entryToBeDeleted : StockEntry) {
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            
            appDelegate.managedObjectContext.delete(entryToBeDeleted)
        }
    }
    
    
    
    
//Button Action
    

    @IBAction func saveEntryButton(sender: UIButton) {
        
        //instantiate the appDelegate
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            
            //create new empty entry
            if let newEntry = NSEntityDescription.insertNewObjectForEntityForName("StockEntry", inManagedObjectContext: appDelegate.managedObjectContext) as? StockEntry {
                
                //populate it
                newEntry.imageReference = "photo.jpg"
                newEntry.stockNumber = "00000000"
                newEntry.website = "shutterstock.com"
                newEntry.clientName = "eviva"
                newEntry.projectNumber = "0000"
                
                //save it
                do {
                    try appDelegate.managedObjectContext.save()
                }
                catch {
                    print(error)
                }
            }
        }
    }
    

    
    
    
//END OF CLASS
    
}

