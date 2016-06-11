//
//  MeMeDetailViewController.swift
//  MeMe
//
//  Created by Akshar Patel on 05/06/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit

class MeMeDetailViewController: UIViewController {
  
  /// (segue!) The meme to display in detail.
  var meme: MeMe!
  
  // MARK: Outlets
  @IBOutlet weak var generatedMemeImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let meme = meme {
      generatedMemeImage.image = meme.memedImage
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let identifier = segue.identifier else {
      return
    }
    
    switch identifier {
    case Constants.Segues.editMeme:
      guard let editorNavigationController = segue.destinationViewController as? UINavigationController, editorController = editorNavigationController.topViewController as? MeMeEditorViewController, meme = meme else {
        print("Did not get reference to MemeEditor")
        return
      }
      
      editorController.memeToEdit = meme
      
    default:
      return
    }
  }
}
