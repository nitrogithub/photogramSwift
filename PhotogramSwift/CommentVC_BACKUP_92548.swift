//
//  CommentVC.swift
//  PhotogramSwift
//
//  Created by Kevin Kim on 4/11/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit
import CoreData

class CommentVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {


    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var spacerBottomConstraint: NSLayoutConstraint!
<<<<<<< HEAD
//    var image = Image() --> This is incorrect
=======
>>>>>>> origin/master
    var image : Image!
    
    //var user : User!
    // currently save the comment into an array, needs to be save in core data
    var comment = [String]()
    //var fetchedResultsController: NSFetchedResultsController()
    var moc : NSManagedObjectContext!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.moc = appDelegate.managedObjectContext
        
        
        
        navigationController!.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = UIColor.grayColor()
        self.myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShowNotification(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHideNotification(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotificationUpdateKeyboard(notification)
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotificationUpdateKeyboard(notification)
    }
    
    func updateBottomLayoutConstraintWithNotificationUpdateKeyboard(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions(rawValue: (UInt(rawAnimationCurve)|UInt(1<<2)))
        
        spacerBottomConstraint.constant = CGRectGetMinY(convertedKeyboardEndFrame)-CGRectGetMaxY(view.bounds)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: animationCurve, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    @IBAction func onPressedSendButton(sender: AnyObject) {
        recordComment()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return image.userComment!.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell")
        let row = indexPath.row
        let comment = self.image.userComment!.objectAtIndex(row)
        cell!.textLabel?.text = comment.comment
        return cell!
    }

    func recordComment() {
        let comment = NSEntityDescription.insertNewObjectForEntityForName("Comment", inManagedObjectContext: self.moc) as! Comment

        comment.comment = self.commentTextField.text!
        comment.isLike = 5 // TODO
        comment.image = self.image
        comment.user = self.image.user
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print("Could not save comment to image \(error), \(error.userInfo)")
        }
        
        self.commentTextField.text = nil
        self.myTableView.reloadData()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        recordComment()
        textField.resignFirstResponder()
        return true
    }

}
