//
//  MainFeedVC.swift
//  PhotogramSwift
//
//  Created by Kevin Kim on 4/7/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit
import CoreData

class MainFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var testArray = []
    var testObject1 = TestObject()
    var testObject2 = TestObject()
    var testObject3 = TestObject()
    var moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    
    var users = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeButton: UIBarButtonItem!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up MOC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.moc = appDelegate.managedObjectContext
        
//        testObject1.name = "Kevin"
//        testObject1.image = "yosemite"
//        testObject1.comments = ["wow thats great", "time to go try it out!","nice shot!"]
//        
//        testObject2.name = "Atousa"
//        testObject2.image = "yosemite"
//        testObject2.comments = ["interesting", "lame","nice!"]
//        
//        testObject3.name = "David"
//        testObject3.image = "yosemite"
//        testObject3.comments = ["hmmmmm...", "way to go","lolol"]
//        testArray = [testObject1, testObject2, testObject3]
        
        self.loadFromCoreData()
        if self.users.count == 0 {
            print("empty MOC, createInitialData")
            self.createInitialData()
        }
        
    }
    
    
    
    func createInitialData() {
        let user1 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.moc) as! User
        user1.realName = "Kevin Kim"
        user1.profileName = "KDawg"
        user1.gender = "Male"
//        user1.image = 
        self.saveData()
    }
    
    
    func loadFromCoreData (){
        //        MOC and fetching data
        let fetchRequest = NSFetchRequest(entityName: "User")
        do {
            let results = try moc.executeFetchRequest(fetchRequest)
            //            creaturesMOC = results as! [NSManagedObject]
            self.users = results as! [NSMutableArray]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func saveData() {
        do {
            try moc.save()
            print("saveData: Saving MOC")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! FeedTableViewCell
        let userTemp = self.users[indexPath.row] as! User
        cell.usernameLabel.text = userTemp.profileName
        print("\(userTemp.profileName)")
//        cell.profileImage.image = 
//        cell.timeUploadedLabel.text =
//        cell.mainImageView.image = 
        
        
//        let cell2 = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath)
//        let cell3 = tableView.dequeueReusableCellWithIdentifier("likeCell", forIndexPath: indexPath)
//        let cell4 = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
//        cell.userName.text = testArray[indexPath.row].name
        return cell
    }

    func commentSeguePlease() {
        self.performSegueWithIdentifier("commentSegue", sender: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
}
