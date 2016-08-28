//
//  DataManager.swift
//  StockBox
//
//  Created by Michael Manisa on 8/22/16.
//  Copyright © 2016 Michael Manisa. All rights reserved.
//

import UIKit
import CoreData


class DataManager {
    
//emptyArray to Store the Data
    
    private var StockLibrary : [StockEntry]
    
    //var testLibrary = ["alecia", "morgan", "tyler"]
    
    static let sharedManager = DataManager()
    
    init() {
        
        self.StockLibrary = [StockEntry]()
        
        if self.StockLibrary.count == 0 {
            
            self.loadEntries()
        }
        
    }
    
    
    
//returns the StockLibrary for external classes
    
//    func getEntries() -> [StockEntry] {
//        
//        return self.StockLibrary
//    }
        func getLibrary() -> [StockEntry] {
    
            self.StockLibrary = self.loadEntries()
            return self.StockLibrary
        }
    
    
    func getLibraryAfterSearch() -> [StockEntry] {
        
        return self.StockLibrary
    }
    
    
//updates entry in StockLibrary
    
//    func updateEntry(updatedEntry : StockEntry) -> Bool {
//        
//        
//        let filteredList = self.StockLibrary.filter{$0.stockNumber == updatedEntry.stockNumber}
//        
//        
//        if filteredList.count > 0 {
//            
//            let c = filteredList[0]
//            
//            c.imageReference = updatedEntry.imageReference
//            c.stockNumber = updatedEntry.stockNumber
//            c.website = updatedEntry.website
//            c.clientName = updatedEntry.clientName
//            c.projectNumber = updatedEntry.projectNumber
//            
//            return true
//            
//        }
//        
//        return false
//    }
    
//SEARCH FUNCTION
    
    func search(input: String) -> [StockEntry] {
        
        //let searchResults = self.StockLibrary.filter{$0.stockNumber == input}
        var searchResultsArray : [StockEntry] = [StockEntry]()
        for x in StockLibrary {
            if x.stockNumber == input {
                print(x.stockNumber! + ": " + x.clientName!)
                searchResultsArray += [x]
            }
        }
        self.StockLibrary = searchResultsArray
        return StockLibrary
    }

    
    
//NOTIFICATIONS
    
    func publishMessage(message:Bool) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("ENTRY_CHANGED", object: self, userInfo: ["message" : message])
        
    }
    
    func publishMessageAdd(message : Bool) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("ENTRY_ADDED", object: self, userInfo: ["message" : message])
        
    }
    
    func publishMessageDelete(message:Bool) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("ENTRY_DELETED", object: self, userInfo: ["message" : message])
        
    }
    
    
    
//LOAD DATA FROM CORE DATA

    
    private func loadEntries() -> [StockEntry] {
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            
            let fetch = NSFetchRequest(entityName: "StockEntry")
            
            
            do {
                
                if let results = try appDelegate.managedObjectContext.executeFetchRequest(fetch) as? [StockEntry] {
                    
                    StockLibrary = results
                }
                
                
            }
                
            catch {
                
                print(error)
            }
            
            
        }
        
        return StockLibrary
        
    }
    
    
    
    
    
    
    ////Add entry
    //
    //    func addEntry(newContact: StockEntry) -> Bool {
    //
    //        self.StockLibrary.append(newContact)
    //
    //        self.saveEntry()
    //
    //        publishMessageAdd(true)
    //
    //        return true
    //    }
    //
    ////delete entry
    //
    //    func deleteEntry(EntryToDelete: StockEntry) -> Bool {
    //
    //        var index = 0
    //
    //        for x in StockLibrary {
    //
    //            if x.stockID == EntryToDelete.stockID {
    //
    //                self.StockLibrary.removeAtIndex(index)
    //
    //                print("x.stockNumber \(x.stockNumber)")
    //
    //                saveEntry()
    //
    //                publishMessageDelete(true)
    //
    //                return true
    //            }
    //            
    //            index += 1
    //        }
    //        
    //        return false
    //    }
    
    
    
    
    
    
    
    
//End Class
    
}
