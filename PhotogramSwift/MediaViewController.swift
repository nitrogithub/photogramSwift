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

class MediaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var mediaBar: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    //Variables
    var newMedia: Bool?
    
    
    // View DID load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        nextButton.layer.cornerRadius = 0.05 * nextButton.bounds.size.width
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
    
    
    
    // Segue - passing image to sharing screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dVC = segue.destinationViewController as! ShareViewController
        //        dVC.shareImage = imageView
    }
    
    
    // Perform Segue on NEXT button pressed
    @IBAction func onNextButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("GoToShareScreenVC", sender: self)
        
    }
}
