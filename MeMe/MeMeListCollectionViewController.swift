//
//  MeMeListCollectionViewController.swift
//  MeMe
//
//  Created by Akshar Patel on 05/06/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCollectionCell"

class MeMeListCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var memeImage: UIImageView!
}

class MeMeListCollectionViewController: UICollectionViewController {
  
  var memes = [MeMe]()
  var appDelegate: AppDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  }
  
  override func viewWillAppear(animated: Bool) {
    memes = appDelegate.memes
    collectionView?.reloadData()
  }
  
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    switch segue.identifier! {
    case Constants.Segues.memeDetail:
      guard let detailController = segue.destinationViewController as? MeMeDetailViewController, indexPath = sender as? NSIndexPath else {
        return
      }
      
      detailController.meme = memes[indexPath.item]
      
    default:
      return
    }
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MeMeListCollectionViewCell
    // Configure the cell
    cell.memeImage.image = memes[indexPath.item].memedImage
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier(Constants.Segues.memeDetail, sender: indexPath)
  }
}
