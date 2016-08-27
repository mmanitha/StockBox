//
//  ViewAllViewController.swift
//  StockBox
//
//  Created by Michael Manisa on 8/22/16.
//  Copyright © 2016 Michael Manisa. All rights reserved.
//

import UIKit

class ViewAllViewController: UIViewController {
    
    //initiate an empty stock library
    var StockLibrary = [StockEntry]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.StockLibrary = DataManager.sharedManager.getLibrary()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func printListButton(sender: UIButton) {
        
        print(StockLibrary)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
