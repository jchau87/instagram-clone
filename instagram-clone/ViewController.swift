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
  
  func displayAlert(title: String, message: String) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    alert.addAction(UIAlertAction(title: "ok", style: .Default, handler: { (action) -> Void in
      self.dismissViewControllerAnimated(true, completion: nil)
    }))
    
    self.presentViewController(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func signUp(sender: AnyObject) {
    
    if username.text == "" || password.text == "" {
      
      displayAlert("Error in form", message: "Please enter a username and password")
      
    } else {
      
      activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
      activityIndicator.center = self.view.center
      activityIndicator.hidesWhenStopped = true
      activityIndicator.activityIndicatorViewStyle = .Gray
      view.addSubview(activityIndicator)
      activityIndicator.startAnimating()
      UIApplication.sharedApplication().beginIgnoringInteractionEvents()
      
      let user = PFUser()
      user.username = username.text
      user.password = password.text
      
      var errorMessage = "Please try again later"
      user.signUpInBackgroundWithBlock({ (success, error) -> Void in
        
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        if error == nil {
          // signup successful
        } else {
          
          if let errorString = error!.userInfo["error"] as? String {
            
            errorMessage = errorString
            
          }
          
          self.displayAlert("Failed Signup", message: errorMessage)
        }
        
        
        
      })
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

