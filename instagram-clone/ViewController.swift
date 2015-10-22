//
//  ViewController.swift
//  instagram-clone
//
//  Created by Johnny Chau on 10/19/15.
//  Copyright © 2015 Chowfun. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

  @IBOutlet weak var username: UITextField!
  @IBOutlet weak var password: UITextField!
  
  @IBOutlet weak var signupButton: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  
  var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
  
  @IBAction func signUp(sender: AnyObject) {
    
    if username.text == "" || password.text == "" {
      let alert = UIAlertController(title: "Error in form", message: "Please enter a username and password",
        preferredStyle: UIAlertControllerStyle.Alert)
      
      alert.addAction(UIAlertAction(title: "ok", style: .Default, handler: { (action) -> Void in
        self.dismissViewControllerAnimated(true, completion: nil)
      }))
      
      self.presentViewController(alert, animated: true, completion: nil)
      
    } else {
      
      activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
      activityIndicator.center = self.view.center
      activityIndicator.hidesWhenStopped = true
      activityIndicator.activityIndicatorViewStyle = .Gray
      view.addSubview(activityIndicator)
      activityIndicator.startAnimating()
      UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
  }
  
  @IBAction func login(sender: AnyObject) {
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

