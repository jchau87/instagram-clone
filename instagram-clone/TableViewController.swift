//
//  TableViewController.swift
//  instagram-clone
//
//  Created by Johnny Chau on 10/24/15.
//  Copyright © 2015 Chowfun. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {
  
  var usernames = [""]
  var userIds = [""]
  var isFollowing = ["":false]
  
  var refresher:UIRefreshControl!
  
  func refresh() {
    
    populateData()
    self.refresher.endRefreshing()
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    refresher = UIRefreshControl()
    refresher.attributedTitle = NSAttributedString(string: "Pull to refresh!")
    refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    self.tableView.addSubview(refresher)
    
    populateData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return usernames.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
    // Configure the cell...
    cell.textLabel?.text = usernames[indexPath.row]
    
    if isFollowing[self.userIds[indexPath.row]] == true {
      cell.accessoryType = .Checkmark
    }
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
    
    // create follow
    let follower = PFObject(className: "Follower")
    follower["following"] = userIds[indexPath.row]
    follower["follower"] = PFUser.currentUser()?.objectId
    
    follower.saveInBackground()
  }
  
  func populateData() {
    let query = PFUser.query()
    query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
      if let users = objects {
        
        self.usernames.removeAll(keepCapacity: true)
        self.userIds.removeAll(keepCapacity: true)
        self.isFollowing.removeAll(keepCapacity: true)
        
        for object in users {
          if let user = object as? PFUser {
            self.usernames.append(user.username!)
            self.userIds.append(user.objectId!)
            
            let query = PFQuery(className: "follower")
            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
            query.whereKey("following", equalTo: user.objectId!)
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
              if let _ = objects {
                self.isFollowing[user.objectId!] = true
              } else {
                self.isFollowing[user.objectId!] = false
              }
            })
          }
        }
      }
    })
  }
  
}
