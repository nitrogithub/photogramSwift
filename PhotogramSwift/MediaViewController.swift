//
//  MediaViewController.swift
//  PhotogramSwift
//
//  Created by David Iskander on 4/10/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices
import CoreData

class MediaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var mediaBar: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    var user : User?

    
    //Variables
    var newMedia: Bool?
    
    
    // View DID load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
        // Navigation Bar UI
        navigationController!.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = UIColor.grayColor()
        
        
        //Image 
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.layer.cornerRadius = 10.0
        
        // Next Button
        nextButton.backgroundColor = UIColor.init(colorLiteralRed: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        nextButton.layer.cornerRadius = 0.01 * nextButton.bounds.size.width

        
        
        if let user = self.user {
            
            print(user.realName, user.gender, user.profileName)
        }
        
        

    }
    
    
    
    // View WILL load
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        mediaBar.selectedSegmentIndex = -1
    }
    
    
    
    // the switch between camera and library
    @IBAction func photoTypeSelector(sender: UISegmentedControl){
        switch mediaBar.selectedSegmentIndex
        {
        case 0:
            useCamera()
            
            
        case 1:
            useCameraRoll()
            
            
        default:
            break;
        }
    }
    
    
    
    // Camera
    func useCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false // If True, it shows up square on screen
            
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
            
            imageView.image = image
            
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
    
    
    
     //Segue - passing image to sharing screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShareVC"
        {
            let dvc = segue.destinationViewController as! SharingViewController
            dvc.user = self.user
            dvc.recievedImage = imageView.image!
            print ("I'm passing this user to sharing screen\(self.user)")
            
        }
    }
    
    
    // Perform Segue on NEXT button pressed
    @IBAction func onNextButtonPressed(sender: AnyObject)
    {
        performSegueWithIdentifier("ShareVC", sender: self)
        
    }
    
    
}
