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
  var noMemesMessageView: UIView!
  var noMemesMessageLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    noMemesMessageView = UIView(frame: collectionView!.bounds)
    noMemesMessageLabel = UILabel(frame: CGRectInset(collectionView!.bounds, 10.0, 10.0))
    noMemesMessageLabel.text = "You have not shared any Memes yet. Create and share Memes to see them here."
    noMemesMessageLabel.font = UIFont.systemFontOfSize(15)
    noMemesMessageLabel.textColor = UIColor.lightGrayColor()
    noMemesMessageLabel.lineBreakMode = .ByWordWrapping
    noMemesMessageLabel.numberOfLines = 3
    noMemesMessageLabel.textAlignment = .Center
    
    noMemesMessageView.addSubview(noMemesMessageLabel)
    
    view.addSubview(noMemesMessageView)
  }
  
  override func viewWillAppear(animated: Bool) {
    memes = appDelegate.memes
    
    noMemesMessageView.hidden = memes.count > 0
    
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
