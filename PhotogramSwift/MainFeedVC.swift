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
            print("core data users is empty, createInitialData")
            self.createInitialUserData()
            self.saveData()
            self.loadFromCoreData()
            
            self.createInitialImageData()
            self.saveData()
            self.loadFromCoreData()
        }
        
        self.tableView.reloadData()
        
        for u in self.users {
            let user = u as! User
            print("\(user.realName)")
            print("\(user.profileName)")
            print("\(user.gender)")

        }
        
        for i in self.images {
            let image = i as! Image
            print("\(image.user?.profileName)")
//            print("\(image.image)")
            print("\(image.user?.realName)")
        }

    }
    
    
    
    func createInitialUserData() {
        let nowTime = NSDate()
        print("creating initial user data")
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
    }
    
    
    func createInitialImageData() {
        let nowTime = NSDate()
        print("creating initial image data")
        print("\(nowTime)")
 
        let image1 = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.moc) as! Image
        image1.image = UIImagePNGRepresentation(UIImage.init(named: "yosemite")!)
        let tempUser1 = self.users[0] as! User
        print("\(tempUser1.profileName)")
        image1.user = tempUser1
        print("\(image1.user?.profileName)")
        
        let image2 = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.moc) as! Image
        image2.image = UIImagePNGRepresentation(UIImage.init(named: "squareImage1")!)
        let tempUser2 = self.users[1] as! User
        print("\(tempUser2.profileName)")
        image2.user = tempUser2
        print("\(image2.user?.profileName)")
        
        let image3 = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.moc) as! Image
        image3.image = UIImagePNGRepresentation(UIImage.init(named: "squareImage2")!)
        let tempUser3 = self.users[2] as! User
        print("\(tempUser3.profileName)")
        image3.user = tempUser3
        print("\(image3.user?.profileName)")
    }
    
    
    func loadFromCoreData(){
        print("loading core data")
        //        MOC and fetching data
        
        let fetchRequest = NSFetchRequest()
        let fetchRequest1 = NSEntityDescription.entityForName("User", inManagedObjectContext: self.moc)
        fetchRequest.entity = fetchRequest1
        do {
            let results = try moc.executeFetchRequest(fetchRequest)
            //            creaturesMOC = results as! [NSManagedObject]
            self.users = results as! [NSMutableArray]
            print("count of users \(self.users.count)")
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
        let fetchRequest2 = NSFetchRequest(entityName: "Image")
        do {
            let results = try moc.executeFetchRequest(fetchRequest2)
            //            creaturesMOC = results as! [NSManagedObject]
            self.images = results as! [NSMutableArray]
            print("count of images \(self.images.count)")
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        print("finished cored data loading")

    }
    
    func saveData() {
        print("saving data")
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
            desVC.user = self.users[0] as? User
            
        } else if segue.identifier == "commentSegue" {
            // Atousa:: Convert from UIButton to IndexPath
            let pointInTable: CGPoint = sender!.convertPoint(sender!.bounds.origin, toView: self.tableView)
            let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
            let row = cellIndexPath!.row

            // Atousa:: Pick the image at IndexPath.row
            let desVC = segue.destinationViewController as! CommentVC
            desVC.image = self.images[row] as? Image            
        } else if segue.identifier == "profileSegue" {
            print("profile segue underway")
           let desVC = segue.destinationViewController as! EditProfileViewController
            let user = self.users[0] as! User
           desVC.user = user
        }
    }
    
    
    @IBAction func profileButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("profileSegue", sender: self.users[0] as! User)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}

    
    
    func didSharedImage(moc:NSManagedObjectContext) {
        self.moc = moc
        self.saveData()
        self.loadFromCoreData()
        self.tableView.reloadData()
        
    }
}
