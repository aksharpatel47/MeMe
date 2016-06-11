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
}
