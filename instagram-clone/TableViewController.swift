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
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
      var query = PFUser.query()
      
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
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
