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
    
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        print("Returned from detail screen")
    }
    
    
    
//ADD/UPDATE ENTRY
    
    func addEntry() {
        

        
    }
    
    
    
    
//DELETE ENTRY
    
    
    @IBAction func deleteButton(sender: UIButton) {
        
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                
                    appDelegate.managedObjectContext.delete(recievedEntry)
                
            }
    }
    
//    func deleteEntry(entryToBeDeleted : StockEntry) {
//        
//        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
//            
//            appDelegate.managedObjectContext.delete(entryToBeDeleted)
//        }
//    }
    
    
    
    
//Button Action
    

    @IBAction func saveEntryButton(sender: UIButton) {
        
        //instantiate the appDelegate
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            
            //create new empty entry
            if let newEntry = NSEntityDescription.insertNewObjectForEntityForName("StockEntry", inManagedObjectContext: appDelegate.managedObjectContext) as? StockEntry {
                
                //populate it
                newEntry.imageReference = imageField.text
                newEntry.stockNumber = stockNumber.text
                newEntry.website = website.text
                newEntry.clientName = clientName.text
                newEntry.projectNumber = taskNumber.text
                
                //send update notification
                DataManager.sharedManager.publishMessage(true)
                
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

