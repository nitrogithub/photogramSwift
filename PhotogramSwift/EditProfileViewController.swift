//
//  EditProfileViewController.swift
//  PhotogramSwift
//
//  Created by David Iskander on 4/11/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit
import Photos
import CoreData
import MobileCoreServices


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //@IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userGender: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    var user : User?
    var moc : NSManagedObjectContext?
    
    //Variables
    var newMedia: Bool?
    var genderType: String = ""
    
    
    override func viewWillAppear(animated: Bool) {
        if genderType == "Male" {
            userGender.selectedSegmentIndex = 0
        }else{
            userGender.selectedSegmentIndex = 1
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // if user exists...
        if let usr = self.user {
            
            // pull attribues from user
            userName.text = usr.realName
            genderType = usr.gender!
        }
    
        if (user!.userProfileImage != nil) {
            profileImage.image = UIImage(data: user!.userProfileImage!)
        } else{
            profileImage.image = UIImage(named: "ProfilePicDefault")
        }
        
        
        // UI stuff
        self.view.backgroundColor = UIColor.blackColor()
        
        //Profile Image/rounded corners w/ frame
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        // UX enable/disable buttons
        profileImage.userInteractionEnabled = false
        userName.userInteractionEnabled = false
        userGender.userInteractionEnabled = false
        
        userName.resignFirstResponder()
    }

    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userName.resignFirstResponder()
        return true;
    }
    
    
    
    @IBAction func onEditProfileButtonPressed(sender: AnyObject)
    {
        
        if (self.navigationItem.rightBarButtonItem!.title == "Edit") {
            self.navigationItem.rightBarButtonItem!.title = "Done"
            
            // UX enable/disable buttons
            profileImage.userInteractionEnabled = true
            userName.userInteractionEnabled = true
            userGender.userInteractionEnabled = true
            
            //Assign tap gesture to profile Image
            let tap = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.imageTapped(_:)))
            profileImage.addGestureRecognizer(tap)
            
            


        }else {
            self.navigationItem.rightBarButtonItem!.title = "Edit"
            profileImage.userInteractionEnabled = false
            userName.userInteractionEnabled = false
            userGender.userInteractionEnabled = false
            
            // CoreData
          
            user?.realName = userName.text
            user?.gender = genderType
            
            let imageData = UIImagePNGRepresentation (profileImage.image! )! as NSData
            user?.userProfileImage = imageData
            
            // moc delegate
            let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
            self.moc = appDelegate?.managedObjectContext
            self.saveData()
            
        
        }
    }
    
    
    // Tap gesture handeler
    func imageTapped(img: AnyObject)
    {
        let alertController = UIAlertController(title: "Change Profile picture", message: "select one", preferredStyle: .ActionSheet)
        
        
        alertController.addAction(UIAlertAction(title: "Choose from Library", style: UIAlertActionStyle.Default, handler: { (action) in
            self.useCameraRoll()
        }))
        
        alertController.addAction(UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default, handler: { (action) in
            self.useCamera()
            }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    // Camera
    func useCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            newMedia = true
        }
    }
    
    
    
    // Photo Library
    func useCameraRoll() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true,completion: nil)
            newMedia = false
        }
    }
    
    
    
    // saving the new images to phone
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType.isEqual (kUTTypeImage)
        {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            profileImage.image = image
            
            
            if (newMedia == true)
            {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(MediaViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
    }
    
    
    
    // Handeling Saving Errors
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                                       completion: nil)
        }
    }
    
    
    
    // Handeling cancelling picking a new image
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // Gender Selection
    @IBAction func genderSelection(sender: AnyObject) {
       
        
        switch userGender.selectedSegmentIndex
        {
        case 0:
            genderType = "Male"
            
        case 1:
            genderType = "Female"
            
        default:
            break;
        }
        
    }
    
    
    
    // Saving to MOC
    func saveData() {
        print("saving data")
        do {
            try moc!.save()
            print("saveData: Saving MOC")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    

    
    
}
