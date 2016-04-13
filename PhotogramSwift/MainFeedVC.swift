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
    var images = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeButton: UIBarButtonItem!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up MOC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.moc = appDelegate.managedObjectContext
        
     
        
        self.loadFromCoreData()
        if self.users.count == 0 {
            print("empty MOC, createInitialData")
            self.createInitialData()
            self.loadFromCoreData()
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    func createInitialData() {
        let nowTime = NSDate()
        
        print("\(nowTime)")
        
        let user1 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.moc) as! User
        user1.realName = "Kevin Kim"
        user1.profileName = "KDawg"
        user1.gender = "Male"
        
        let user2 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.moc) as! User
        user2.realName = "Atousa D"
        user2.profileName = "ADawg"
        user2.gender = "Female"
        
        let user3 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.moc) as! User
        user3.realName = "David I"
        user3.profileName = "DDawg"
        user3.gender = "Male"
        
        let image1 = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.moc) as! Image
        image1.image = UIImagePNGRepresentation(UIImage.init(named: "yosemite")!)
//        image1.timeStamp =
        image1.user? = user1
        
        let image2 = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.moc) as! Image
        image2.image = UIImagePNGRepresentation(UIImage.init(named: "squareImage1")!)
        //        image1.timeStamp =
        image2.user? = user2
        
        let image3 = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.moc) as! Image
        image3.image = UIImagePNGRepresentation(UIImage.init(named: "squareImage2")!)
        //        image1.timeStamp =
        image3.user? = user2
        
        
        //temporarily disabled saving data
        self.saveData()
    }
    
    
    func loadFromCoreData(){
        //        MOC and fetching data
        let fetchRequest1 = NSFetchRequest(entityName: "User")
        do {
            let results = try moc.executeFetchRequest(fetchRequest1)
            //            creaturesMOC = results as! [NSManagedObject]
            self.users = results as! [NSMutableArray]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
        let fetchRequest2 = NSFetchRequest(entityName: "Image")
        do {
            let results = try moc.executeFetchRequest(fetchRequest2)
            //            creaturesMOC = results as! [NSManagedObject]
            self.images = results as! [NSMutableArray]
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
        cell.imageCell = self.images[indexPath.row] as? Image
        return cell
    }

//    func commentSeguePlease() {
//        self.performSegueWithIdentifier("commentSegue1", sender: self)
//    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cameraSegue" {
            let desVC = segue.destinationViewController as! MediaViewController
            //desVC.user = self.users[0] as! User
            
        } else if segue.identifier == "commentSegue" {
            let desVC = segue.destinationViewController as! CommentVC
            desVC.image = sender as! Image
            
        } else if segue.identifier == "profileSegue" {
           let desVC = segue.destinationViewController as! EditProfileViewController
           //desVC.user = self.users[0] as! User
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    
    func didSharedImage() {
        //LOAD FORM CORE DATA
        
        self.saveData()
        self.loadFromCoreData()
        self.tableView.reloadData()
        
    }
}
