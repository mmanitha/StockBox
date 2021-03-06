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
    
    
    
    
    //----------------IMAGE RESIZE----------------
    
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    //self.ResizeImage(UIImage(named: "yourImageName")!, targetSize: CGSizeMake(200.0, 200.0))

    
    
    
    
    //----------------SERIALIZATION STUFF-----------------
    
    
    //SAVING TO DISK - (reasoning) creates destination path, saves it, then returns the path so the StockEntry entity can store it.
    
    
    func saveImage(image : UIImage) -> String {
        
        let destinationPath =  "\(self.filePathForArchiving())/\(NSUUID().UUIDString).png"
        
        let converter = UIImagePNGRepresentation(image)
        
        
        
        do {
            try converter?.writeToFile(destinationPath, options: .AtomicWrite)
        }
        catch {
         
            print(error)
        }
        
        return destinationPath
    }
    

    //LOADING FROM DISK - (reasoning) public loadImage function that will take a destination path in the form of a String to return a requested image from the disk.

    func loadImage(requestedPath : String) -> UIImage? {
        
        let baseUrl = self.filePathForArchiving()
        
        let destinationPath = "\(baseUrl)/\(requestedPath)"
        
        return UIImage(contentsOfFile: destinationPath)
        
    }
    
    
    //creating file in which to store images
    
    private func filePathForArchiving() -> String {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
//        let destinationPath = "\(documentsPath)/SavedImages"
        
        return documentsPath
    }
    
    
    
    
    
    
    
    
    
    //DELETE ENTRY
    
//    func DeleteEntry(indexToBeDeleted : Int) -> [StockEntry] {
//        
//        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
//            
//            //let fetch = NSFetchRequest(entityName: "StockEntry")
//            
//            //configure predicate property here
//        
//            do {
//                
//                //if let results = try appDelegate.managedObjectContext.executeFetchRequest(fetch) as? [StockEntry] {
//                    
//                    appDelegate.managedObjectContext.deleteObject(StockLibrary[indexToBeDeleted])
//                    
//                    //appDelegate.managedObjectContext.save()
//                    
//                    StockLibrary.removeAtIndex(indexToBeDeleted)
//                //}
//                
//                try appDelegate.managedObjectContext.save()
//                
//            }
//                
//            catch {
//                
//                print(error)
//            }
//            
//            
//        }
//        
//        return StockLibrary
//        
//    }
//    
    

    
    
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
