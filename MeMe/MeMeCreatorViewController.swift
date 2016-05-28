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
  @IBOutlet weak var bottomToolbar: UIToolbar!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var memeView: UIView!
  
  /// Boolean value which determines if the image should be cropped after picking / taking it from camera / library
  var allowImageCrop = true
  /// This variables stores the font that the Meme creator will use.
  var fontToUse = "Impact"
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    topTextView.delegate = self
    bottomTextView.delegate = self
    
    shareButton.enabled = false
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
      cameraButton.enabled = false
    }
    
    // Getting the values from user defaults.
    allowImageCrop = NSUserDefaults.standardUserDefaults().boolForKey(Constants.OfflineKeys.imageCropPreference)
    fontToUse = NSUserDefaults.standardUserDefaults().stringForKey(Constants.OfflineKeys.fontToUse)!
    
    // Attributes of top and bottom text fields
    let memeTextAttributes: [String:AnyObject] = [
      NSForegroundColorAttributeName: UIColor.whiteColor(),
      NSFontAttributeName: UIFont(name: fontToUse, size: 40)!,
      NSStrokeColorAttributeName: UIColor.blackColor(),
      NSStrokeWidthAttributeName: -3.0
    ]
    
    topTextView.defaultTextAttributes = memeTextAttributes
    bottomTextView.defaultTextAttributes = memeTextAttributes
    topTextView.textAlignment = .Center
    bottomTextView.textAlignment = .Center
    
    subscribeToKeyboardEvents()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    unsubscribeFromKeyboardEvents()
  }
  
  // MARK: Actions
  @IBAction func pickImageFromGallery(sender: UIBarButtonItem) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = .PhotoLibrary
    imagePickerController.allowsEditing = allowImageCrop
    imagePickerController.delegate = self
    
    presentViewController(imagePickerController, animated: true, completion: nil)
  }
  
  @IBAction func getImageFromCamera(sender: UIBarButtonItem) {
    let getImageController = UIImagePickerController()
    getImageController.sourceType = .Camera
    getImageController.allowsEditing = allowImageCrop
    getImageController.delegate = self
    
    presentViewController(getImageController, animated: true, completion: nil)
  }
  
  @IBAction func shareMemedImage(sender: UIBarButtonItem) {
    let memedImage = generateMemedImage()
    let shareActivityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    shareActivityViewController.completionWithItemsHandler = ({
      activityType, completed, returnedItems, activityError in
      self.save()
      self.dismissViewControllerAnimated(true, completion: nil)
    })
    presentViewController(shareActivityViewController, animated: true, completion: nil)
  }
  
  @IBAction func resetMemeEditor(sender: UIBarButtonItem) {
    imageView.image = nil
    topTextView.text = "TOP"
    bottomTextView.text = "BOTTOM"
    shareButton.enabled = false
  }
  
  /// This function subscribes the controller to keyboard notifications. This is required to push the view upwards when the keyboard
  /// appears.
  func subscribeToKeyboardEvents() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardEvents() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }
  
  /// When the keyboard hides, we set the frame's y origin to its initial value.
  func keyboardWillHide(notification: NSNotification) {
    view.frame.origin.y = 0
  }
  
  func keyboardWillShow(notification: NSNotification) {
    if bottomTextView.isFirstResponder() {
      if let height = getKeyboardHeight(notification) {
        view.frame.origin.y -= height
      }
    }
  }
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
    guard let userInfo = notification.userInfo, value = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
      print("Did not get required data from notification's userinfo.")
      return nil
    }
    
    let keyboardFrame = value.CGRectValue()
    return keyboardFrame.height
  }
  
  /// Save function save's the meme.
  func save() {
    let _ = MeMe(topText: topTextView.text!, bottomText: bottomTextView.text!, image: imageView.image!, memedImage: generateMemedImage())
  }
  
  func generateMemedImage() -> UIImage {
    // Using memeView and its bounds to draw graphics instead of the main view. Hence, hiding navigationBar and bottomBar not necessary.
    UIGraphicsBeginImageContextWithOptions(memeView.frame.size, true, 0.0)
    memeView.drawViewHierarchyInRect(memeView.bounds, afterScreenUpdates: true)
    let memedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return memedImage
  }
}

// MARK: - UIImagePickerControllerDelegate
extension MeMeCreatorViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    dismissViewControllerAnimated(true, completion: nil)
    let imageKey = allowImageCrop ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage
    if let image = info[imageKey] as? UIImage {
      imageView.image = image
      shareButton.enabled = true
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
