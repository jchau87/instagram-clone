//
//  PostImageViewController.swift
//  instagram-clone
//
//  Created by Johnny Chau on 10/28/15.
//  Copyright © 2015 Chowfun. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  var activityIndicator = UIActivityIndicatorView()
  
  @IBOutlet weak var imageToPost: UIImageView!
  @IBOutlet weak var message: UITextField!
  
  @IBAction func chooseAnImage(sender: AnyObject) {
    
    let image = UIImagePickerController()
    image.delegate = self
    image.sourceType = .PhotoLibrary
    image.allowsEditing = false
    
    self.presentViewController(image, animated: true, completion: nil)
    
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    
    self.dismissViewControllerAnimated(true, completion: nil)
    imageToPost.image = image
  }
  
  @IBAction func postImage(sender: AnyObject) {
    
    activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
    activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
    activityIndicator.center = self.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.activityIndicatorViewStyle = .Gray
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    
    let post = PFObject(className: "Post")
    post["message"] = message.text
    post["userId"] = PFUser.currentUser()!.objectId
    let imageData = UIImageJPEGRepresentation(imageToPost.image!, 0.5)
    let imageFile = PFFile(name: "image.png", data: imageData!)
    
    post["imageFile"] = imageFile
    
    post.saveInBackgroundWithBlock { (success, error) -> Void in
      UIApplication.sharedApplication().endIgnoringInteractionEvents()
      
      if error == nil {
        // successful post
      }
      
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
