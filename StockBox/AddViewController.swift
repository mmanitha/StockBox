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
    var checkStockNumber : String = ""
    
    @IBOutlet weak var imageField: UITextField!
    @IBOutlet weak var stockNumber: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var taskNumber: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    
    //Button Action
    
    
    @IBAction func saveEntryButton(sender: UIButton) {
        
        //instantiate the appDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if let context = appDelegate?.managedObjectContext {
            
            let fetchRequest = NSFetchRequest(entityName: "StockEntry")
            
            
            do {
                let entries = try(context.executeFetchRequest(fetchRequest) as? [StockEntry])
                
                var verificationArray : [StockEntry] = [StockEntry]()
                
                for x in entries! {
                    
                    if x.stockNumber == stockNumber.text {
                        
                        verificationArray += [x]
                        
                    }
                }
                
                if verificationArray.count == 0 {
                    
                    //create new empty entry
                    if let newEntry = NSEntityDescription.insertNewObjectForEntityForName("StockEntry", inManagedObjectContext: context) as? StockEntry {
                        
                        //populate it
                        newEntry.imageReference = imageField.text
                        newEntry.stockNumber = stockNumber.text
                        newEntry.website = website.text
                        newEntry.clientName = clientName.text
                        newEntry.projectNumber = taskNumber.text
                    }
                    
                    //save it
                    try context.save()
                    
                    //send update notification
                    DataManager.sharedManager.publishMessage(true)
                }
            }
                
            catch {
                print(error)
            }
        }
    }
    
    
    
    
    
    //END OF CLASS
    
    
}