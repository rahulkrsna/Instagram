//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Rahul Krishna Vasantham on 1/27/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mediaData:[NSDictionary]?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 250
        
        // Do any additional setup after loading the view, typically from a nib.
        getDataFromInstagram()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let mediaData = mediaData {
            return mediaData.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MediaCell", forIndexPath: indexPath) as! MediaCell

        let post = mediaData![indexPath.row]
        
        let images = post["images"]
        let imageChosen = images!["standard_resolution"]
        let picURL = imageChosen!!["url"] as! String
        
        let user = post["user"]
        let fullName = user!["full_name"] as! String
        let profilePicURL = user!["profile_picture"] as! String
        
        NSLog("imageURL: \(picURL)")
        
        cell.pictureView.setImageWithURL(NSURL(string: picURL)!)
        cell.profilePic.setImageWithURL(NSURL(string: profilePicURL)!)
        cell.profileName.text = fullName
        
        return cell
    }
    
    func getDataFromInstagram() {
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.mediaData = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }

}

