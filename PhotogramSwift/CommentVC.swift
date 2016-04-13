//
//  CommentVC.swift
//  PhotogramSwift
//
//  Created by Kevin Kim on 4/11/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit

class CommentVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {


    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var spacerBottomConstraint: NSLayoutConstraint!
    var image = Image()
    
    // currently save the comment into an array, needs to be save in core data
    var comment = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
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
       
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions(rawValue: (UInt(rawAnimationCurve)|UInt(1<<2)))
        
        print("prev \(spacerBottomConstraint.constant) spacer \(view.bounds) keyboard \(convertedKeyboardEndFrame)")
        spacerBottomConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMaxY(convertedKeyboardEndFrame);
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: animationCurve, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)

    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
       
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions(rawValue: (UInt(rawAnimationCurve)|UInt(1<<2)))
        
        print("prev \(spacerBottomConstraint.constant) spacer \(view.bounds) keyboard \(convertedKeyboardEndFrame)")
        spacerBottomConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMaxY(convertedKeyboardEndFrame) ;
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: animationCurve, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }

    /*func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions(rawValue: (UInt(rawAnimationCurve)|UInt(1<<2)))
        
        print("prev \(spacerBottomConstraint.constant) spacer \(view.bounds) keyboard \(convertedKeyboardEndFrame)")
        spacerBottomConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMaxY(convertedKeyboardEndFrame);
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: animationCurve, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }*/
    
    @IBAction func onPressedSendButton(sender: AnyObject) {
        comment.append(self.commentTextField.text!) //might be optional
        print(comment.count)
        self.commentTextField.text = nil
        self.myTableView.reloadData()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell")
        let row = indexPath.row
        cell!.textLabel?.text = self.comment[row]
        return cell!
    
    }


}
