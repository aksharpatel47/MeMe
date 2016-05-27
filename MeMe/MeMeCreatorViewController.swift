//
//  MeMeCreatorViewController.swift
//  MeMe
//
//  Created by Akshar Patel on 23/04/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit

class MeMeCreatorViewController: UIViewController {

  // MARK: Outlets
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var topTextView: UITextField!
  @IBOutlet weak var bottomTextView: UITextField!
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    topTextView.delegate = self
    bottomTextView.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
      cameraButton.enabled = false
    }
    
    let memeTextAttributes: [String:AnyObject] = [
      NSForegroundColorAttributeName: UIColor.whiteColor(),
      NSFontAttributeName: UIFont(name: "Impact", size: 40)!,
      NSStrokeColorAttributeName: UIColor.blackColor(),
      NSStrokeWidthAttributeName: -2.0
    ]
    
    topTextView.defaultTextAttributes = memeTextAttributes
    bottomTextView.defaultTextAttributes = memeTextAttributes
    
    topTextView.textAlignment = .Center
    bottomTextView.textAlignment = .Center
  }
  
  // MARK: Actions
  @IBAction func pickImageFromGallery(sender: UIBarButtonItem) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = .PhotoLibrary
    imagePickerController.allowsEditing = true
    imagePickerController.delegate = self
    
    presentViewController(imagePickerController, animated: true, completion: nil)
  }
  
  @IBAction func getImageFromCamera(sender: UIBarButtonItem) {
    let getImageController = UIImagePickerController()
    getImageController.sourceType = .Camera
    getImageController.allowsEditing = true
    getImageController.delegate = self
    
    presentViewController(getImageController, animated: true, completion: nil)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension MeMeCreatorViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    dismissViewControllerAnimated(true, completion: nil)
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
      imageView.image = image
    }
  }
}

// MARK: - UITextFieldDelegate
extension MeMeCreatorViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField.text == "TOP" || textField.text == "BOTTOM" {
      textField.text = ""
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
