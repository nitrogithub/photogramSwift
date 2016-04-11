//
//  ShareViewController.swift
//  PhotogramSwift
//
//  Created by Atousa Duprat on 4/10/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//


//For Kevin: This object receives an image, annotates the image with a name and geotech info. and pass it to other object for further processing. It is augmented by a function named "didSharedImage". If you want to use this function you need to include the "ShareViewControllerDelegate" protocol in your object.
import UIKit
import Photos
import MapKit

//delegate protocol
protocol ShareViewControllerDelegate: class {
   func didSharedImage(sender: Image)
}

class ShareViewController: UIViewController {
    //Image that passed from other VC
    let recievedImage = UIImage()
    let shareImage = Image()
    
    
    //set up the delegate property
    weak var delegate:ShareViewControllerDelegate?

    //outlets
    @IBOutlet weak var nameOfImage: UITextField!
    @IBOutlet weak var imageToShare: UIImageView!
    @IBOutlet weak var locationOfImage: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareImage.name = self.nameOfImage.text
        shareImage.image = UIImagePNGRepresentation(recievedImage)
        
        //taking the geotech from the received image
        let assetResult = PHAsset.fetchAssetsWithMediaType(.Image,
                                                    options: nil)
        print("Found \(assetResult.count) results")
        let location: CLLocation = assetResult[0].location as CLLocation!
        shareImage.latitude = location.coordinate.latitude
        shareImage.longitude = location.coordinate.longitude
        let geocoder = CLGeocoder()
        
        // convert coordinate to address and show it in the textField
        geocoder.reverseGeocodeLocation(location) {
            (placemarks: [CLPlacemark]?, error) -> Void in
            let placemarks = placemarks! as [CLPlacemark]
                var placemark = CLPlacemark()
                for placemark in placemarks {
                    self.locationOfImage.text = (placemark.locality)
                }
            }
    }
    
        
        // Kevin, When you want to call this methos you need to use this convention in swift :
    //extension MasterViewController:  ShareViewControllerDelegate{
        //func didSharedImage(sender: Image) {
            // do stuff like saving the image
      //  }
   // }
    
    

    @IBAction func onPressedShareButton(sender: AnyObject) {
        
        delegate?.didSharedImage(shareImage)
    }
    
    
    //get GPS coordinate form Image
    
    

   
}
