//
//  MainFeedVC.swift
//  PhotogramSwift
//
//  Created by Kevin Kim on 4/7/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

import UIKit

class MainFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var testArray = []
    var testObject1 = TestObject()
    var testObject2 = TestObject()
    var testObject3 = TestObject()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testObject1.name = "Kevin"
        testObject1.image = "yosemite"
        testObject1.comments = ["wow thats great", "time to go try it out!","nice shot!"]
        
        testObject2.name = "Atousa"
        testObject2.image = "yosemite"
        testObject2.comments = ["interesting", "lame","nice!"]
        
        testObject3.name = "David"
        testObject3.image = "yosemite"
        testObject3.comments = ["hmmmmm...", "way to go","lolol"]
        testArray = [testObject1, testObject2, testObject3]
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! FeedTableViewCell
//        let cell2 = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath)
//        let cell3 = tableView.dequeueReusableCellWithIdentifier("likeCell", forIndexPath: indexPath)
//        let cell4 = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
//        cell.userName.text = testArray[indexPath.row].name
        return cell
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
}
