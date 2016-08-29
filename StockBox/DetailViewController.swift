//
//  DetailViewController.swift
//  StockBox
//
//  Created by Michael Manisa on 8/27/16.
//  Copyright © 2016 Michael Manisa. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var recievedEntry : StockEntry?

    @IBOutlet weak var imgReferenceLabel: UILabel!
    @IBOutlet weak var stockNumberLabel: UILabel!
    @IBOutlet weak var sourceWebsiteLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var projectNumberLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //IF entries were pushed in, fill fields with information:
        if let x = recievedEntry {
            imgReferenceLabel.text = x.imageReference
            stockNumberLabel.text = x.stockNumber
            sourceWebsiteLabel.text = x.website
            clientNameLabel.text = x.clientName
            projectNumberLabel.text = x.projectNumber
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //DELETE ENTRY
    
    
    @IBAction func deleteButton(sender: UIButton) {
        
        if let x = recievedEntry {
            
            deleteEntry(x.stockNumber!)
        }
    
        
//        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
//            
//            appDelegate.managedObjectContext.delete(recievedEntry)
//            
//        }
    }
    
    
    func deleteEntry(stockNumberToBeDeleted : String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if let context = appDelegate?.managedObjectContext {
            
            do {
                
                let fetchRequest = NSFetchRequest(entityName: "StockEntry")
                
                let entries = try(context.executeFetchRequest(fetchRequest) as? [StockEntry])
                
                
                for x in entries! {
                    if x.stockNumber == stockNumberToBeDeleted {
                        context.deleteObject(x)
                    }
                }
                
                try(context.save())
                
                DataManager.sharedManager.publishMessageDelete(true)
                
            }
            catch {
                
                print(error)
            }
        }
        
    }
    
    

    
    
    
    
    
    //    func deleteEntry(entryToBeDeleted : StockEntry) {
    //
    //        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
    //
    //            appDelegate.managedObjectContext.delete(entryToBeDeleted)
    //        }
    //    }
    
    
    
    
    
    

}
