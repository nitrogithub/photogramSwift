//
//  FeedTableViewCell.swift
//  PhotogramSwift
//
//  Created by Kevin Kim on 4/7/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit


//protocol TableViewCellDelegate {
//    func toDeleteImage(item: Image)
//}


class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeUploadedLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var commentsTextView: UITextView!
    
//    var originalCenter = CGPoint()
//    var completeOnDragRelease = false
//    var deleteOnDragRelease = false
//    var delegate: TableViewCellDelegate?
//    var image: Image?
//    
    
    
    //1. What needs to be done before this is fired?
    weak var imageCell: Image? {
        didSet {
            self.usernameLabel.text = self.imageCell?.user?.profileName
            self.mainImageView.image = UIImage(data: (self.imageCell?.image)!)
            
            let tempString = NSMutableString()
            for c in imageCell!.userComment! {
                let d = c as! Comment
//                tempString.appendString("\(d.user!.profileName!)- \(d.comment!) \n")
                tempString.appendString("KDawg- \(d.comment!) \n")

            }
            self.commentsTextView.text = tempString as String
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.imageView?.image = UIImage (named: "heartWhite")
        
        // add a double tap recognizer
        let tap = UITapGestureRecognizer(target: self, action: "doubleTapped")
        tap.numberOfTapsRequired = 2
        mainImageView.addGestureRecognizer(tap)
        
//        let frameCell = CGRectMake(0, 0, 150+self.frame.width, self.frame.width)
//        let view4 = UIView.init(frame: frameCell)
//        view4.backgroundColor = UIColor.orangeColor()
//        let part1 = CGRect()
//        let part2 = CGRect()
//        let part3 = CGRect()
//        CGRectDivide(frameCell, part1, part2, 100.0, CGRectGetMaxY(frameCell.maxY))

//        
//        let frameProfile = CGRectMake(0, 0, 50, 50) as CGRect
//        let frameImage = CGRectMake(0, 50, self.frame.width, 50) as CGRect
//        let frameComments = CGRectMake(0, 100, self.frame.width, 100) as CGRect
//
//        let view1 = UIView.init(frame: frameProfile)
//        view1.backgroundColor = UIColor.redColor()
//        
//        let view2 = UIView.init(frame: frameImage)
//        view2.backgroundColor = UIColor.greenColor()
//        
//        let view3 = UIView.init(frame: frameComments)
//        view3.backgroundColor = UIColor.blueColor()
//        
//        self.addSubview(view1)
//        self.addSubview(view2)
//        self.addSubview(view3)
////        self.addSubview(view4)
//
//
//        //
//        //profile Image location and size
//        self.profileImage.frame.size.width = 50
//        self.profileImage.frame.size.height = 50
////        self.profileImage.frame.origin = CGPoint(x: 0, y: self.profileImage.frame.height)
//        self.profileImage.frame.origin = CGPoint(x: 200, y: 200)
////        self.profileImage
////
////        
//
//        //UIImageView height and width are the same. perfect square
//        self.mainImage.frame.origin = CGPoint(x: 0, y: self.profileImage.frame.height)
//        self.mainImage.frame.size.width = self.frame.width
//        self.mainImage.frame.size.height = self.frame.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonPressed(sender: UIButton) {
        //let image = UIImage(named: "heartRed")! as UIImage
        //likeButton.setImage(image, forState: UIControlState.Normal)
        
        if likeButton.imageView?.image == UIImage (named: "heartWhite"){
            let image = UIImage(named: "heartRed")! as UIImage
            likeButton.setImage(image, forState: UIControlState.Normal)
        }else{
            let image = UIImage(named: "heartWhite")! as UIImage
            likeButton.setImage(image, forState: UIControlState.Normal)
        }

    }
    
    func doubleTapped(){
        if likeButton.imageView?.image == UIImage (named: "heartWhite"){
            let image = UIImage(named: "heartRed")! as UIImage
            likeButton.setImage(image, forState: UIControlState.Normal)
        }else{
            let image = UIImage(named: "heartWhite")! as UIImage
            likeButton.setImage(image, forState: UIControlState.Normal)
        }
        
    }

// Atousa:: removed commentButtonPressed() as segue triggered by storyboard
//    @IBAction func commentButtonPressed(sender: UIButton) {
//        let descVC = MainFeedVC()
//
//        //commented out because this isn't working. temporary measure in place
//        descVC.performSegueWithIdentifier("commentSegue", sender: imageCell)
//    }
    



//    //MARK: - horizontal pan gesture methods
//    func handlePan(recognizer: UIPanGestureRecognizer) {
//        // 1
//        if recognizer.state == .Began {
//            // when the gesture begins, record the current center location
//            originalCenter = center
//        }
//        // 2
//        if recognizer.state == .Changed {
//            let translation = recognizer.translationInView(self)
//            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
//            // has the user dragged the item far enough to initiate a delete/complete?
//            deleteOnDragRelease = frame.origin.x < frame.size.width / 5.0
//        }
//        // 3
//        if recognizer.state == .Ended {
//            // the frame this cell had before user dragged it
//            let originalFrame = CGRect(x: 0, y: frame.origin.y,
//                                       width: bounds.size.width, height: bounds.size.height)
//            if !deleteOnDragRelease {
//                // if the item is not being deleted, snap back to the original location
//                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
//            }
//        }
//        
//    }
//    
//    
//    
//    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
//            let translation = panGestureRecognizer.translationInView(superview!)
//            if fabs(translation.x) > fabs(translation.y) {
//                return true
//            }
//            return false
//        }
//        return false
//    }
//    
    
    
}

