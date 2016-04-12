//
//  FeedTableViewCell.swift
//  PhotogramSwift
//
//  Created by Kevin Kim on 4/7/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeUploadedLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var commentsTextView: UITextView!
    
    
    
    //1. What needs to be done before this is fired?
    weak var imageCell: Image? {
        didSet {
            self.usernameLabel.text = self.imageCell?.user?.profileName
            self.mainImageView.image = UIImage(data: (self.imageCell?.image)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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

    }
    @IBAction func commentButtonPressed(sender: UIButton) {
        //        self.delegate.performSegue("commentSegue")
        //        self.performSegueWithIdentifier("commentSegue", sender: nil)
        //let descVC = MainFeedVC()
        //descVC.commentSeguePlease()

    }
    
}
