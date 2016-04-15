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
    var imageCell : Image!
    var moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    
    var users = []
    var images = []
    //var delegate: TableViewCellDelegate?
    //var toDoItem: ToDoItem?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeButton: UIBarButtonItem!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar UI
        navigationController!.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        tableView.backgroundColor = UIColor.init(colorLiteralRed: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        
        
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

            self.tableView.reloadData()
        }
        
        
//        for u in self.users {
//            let user = u as! User
//            print("\(user.realName)")
//            print("\(user.profileName)")
//            print("\(user.gender)")
//
//        }
//        
//        for i in self.images {
//            let image = i as! Image
//            print("\(image.user?.profileName)")
////            print("\(image.image)")
//            print("\(image.user?.realName)")
//        }
        
        
        // tapRecognizer, placed in viewDidLoad
//        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MainFeedVC.longPress(_:)))
//        self.view.addGestureRecognizer(longPressRecognizer)

    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        self.saveData()
        self.tableView.reloadData()
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
        image1.user = self.users[0] as? User
        image1.comment = "ADawg\'s best photo!"
        
        let image2 = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.moc) as! Image
        image2.image = UIImagePNGRepresentation(UIImage.init(named: "squareImage4")!)
        image2.user = self.users[1] as? User
        image2.comment = "DDawg\'s first photo"

        let image3 = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.moc) as! Image
        image3.image = UIImagePNGRepresentation(UIImage.init(named: "squareImage2")!)
        image3.user = self.users[2] as? User
        image3.comment = "KDawg\'s newest photo!"
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
        //cell.selectionStyle = .None
        //cell.delegate = self
        //cell.toDoItem = item
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
    
    func commentButtonSegue(sender: Image)  {
        print("\(sender.user?.profileName)")
        self.imageCell = sender
//        self.performSegueWithIdentifier("commentSeg", sender: self.imageCell)
//        self.performSegueWithIdentifier("profileSegue", sender: nil)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}


    
    
    
    // David delete image cells
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            self.moc = appDelegate.managedObjectContext
            
            //print (indexPath.row)
            
            let image = images[indexPath.row] as! Image
            moc.deleteObject(image)
            self.saveData()
            self.loadFromCoreData()
            self.tableView.reloadData()
        }
    }
    
    
    //Called, when long press occurred
//    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
//        
//        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
//            
//            let touchPoint = longPressGestureRecognizer.locationInView(self.view)
//            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
//                
//                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                self.moc = appDelegate.managedObjectContext
//                
//                // need to extract index "i" from "indexPath"
//                
//                print (indexPath.row)
//
//                let image = images[indexPath.row] as! Image
//                moc.deleteObject(image)
//                self.saveData()
//                
//                //Image.delete(indexPath)
//                //self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//                tableView.reloadData()
//                // your code here, get the row for the indexPath or do whatever you want
//            }
//        }
//    }
    
    
        
    func didSharedImage(moc:NSManagedObjectContext) {
        self.moc = moc
        self.saveData()
        self.loadFromCoreData()

        var abc: NSData?
        
        for i in self.images {
            let d = i as! Image
            print("\(d.user?.profileName)")
            
            if let variable = abc {
                print("not Nil")
            } else {
                print("nothing. it is nil")
            }
            
            
//            print("\(d.image)")

        }
        
        self.tableView.reloadData()
        
    }
}
