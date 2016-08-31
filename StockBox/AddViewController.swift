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


class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var recievedEntry : StockEntry?
    var checkStockNumber : String = ""
    
    @IBOutlet weak var stockNumber: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var taskNumber: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        print("Returned from detail screen")
    }
    
    
    
    //ADD PHOTO FROM CAMERA INTO IMAGEVIEW
    
    @IBAction func openCamera(sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
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
                    
                    //variable to store image path once saveImage func has returned it
                    var imagePath : String?
                    
                    if let x = imageView.image {
                        imagePath = DataManager.sharedManager.saveImage(x)
                    }
                    
                    print(imagePath) // -> print out path just for verification
                    
                    //create new empty entry
                    if let newEntry = NSEntityDescription.insertNewObjectForEntityForName("StockEntry", inManagedObjectContext: context) as? StockEntry {
                        
                        //populate it
                        newEntry.imageReference = imagePath
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