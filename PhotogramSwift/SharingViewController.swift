//
//  SharingViewController.swift
//  PhotogramSwift
//
//  Created by David Iskander on 4/13/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit
import Photos
import MapKit
import CoreData

protocol ShareViewControllerDelegate: class {
    func didSharedImage()
}


class SharingViewController: UIViewController {

    var user : User?
    var recievedImage = UIImage()

    //set up the delegate property
    weak var delegate:ShareViewControllerDelegate?
    
    //outlets
    @IBOutlet weak var nameOfImage: UITextField!
    @IBOutlet weak var imageToShare: UIImageView!
    @IBOutlet weak var locationOfImage: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI stuff
        self.view.backgroundColor = UIColor.blackColor()
        
        //Image/rounded corners w/ frame
        imageToShare.clipsToBounds = true
        imageToShare.layer.borderWidth = 3.0
        imageToShare.layer.borderColor = UIColor.whiteColor().CGColor
        
        // Share Button 
        shareButton.backgroundColor = UIColor.init(colorLiteralRed: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        shareButton.layer.cornerRadius = 0.01 * shareButton.bounds.size.width

        
        // moc delegate
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let moc = appDelegate?.managedObjectContext
        let shareImage = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: moc!) as! Image
        
        // Reciving the image
        imageToShare.image = recievedImage
        
        shareImage.name = self.nameOfImage.text
        shareImage.image = UIImagePNGRepresentation(recievedImage)
        
    }
    
    @IBAction func onPressedShareButton(sender: AnyObject) {
        delegate?.didSharedImage()
    }
    
    
    
    
    
    
    
}
