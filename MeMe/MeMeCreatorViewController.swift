//
//  MeMeCreatorViewController.swift
//  MeMe
//
//  Created by Akshar Patel on 23/04/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit

class MeMeCreatorViewController: UIViewController {

  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
      cameraButton.enabled = false
    }
    
    setNeedsStatusBarAppearanceUpdate()
    navigationController?.navigationBar.barTintColor = UIColor.brownColor()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func pickImageFromGallery(sender: AnyObject) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = .PhotoLibrary
    imagePickerController.delegate = self
    
    presentViewController(imagePickerController, animated: true, completion: nil)
  }
}

extension MeMeCreatorViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    dismissViewControllerAnimated(true, completion: nil)
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.image = image
    }
  }
}

