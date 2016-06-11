//
//  MeMeListTableViewController.swift
//  MeMe
//
//  Created by Akshar Patel on 05/06/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit

class MemeListTableViewCell: UITableViewCell {
  @IBOutlet weak var memeImageView: UIImageView!
  @IBOutlet weak var memeTextView: UILabel!
}

class MeMeListTableViewController: UITableViewController {
  
  var memes: [MeMe] {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    return appDelegate.memes
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    if memes.count == 0 {
      let noMemesFooter = UIView(frame: tableView.bounds)
      let noMemesLabel = UILabel(frame: CGRectInset(tableView.bounds, 10.0, 10.0))
      noMemesLabel.text = "You have not shared any Memes yet. Create and share Memes to see them here."
      noMemesLabel.font = UIFont.systemFontOfSize(15)
      noMemesLabel.textColor = UIColor.lightGrayColor()
      noMemesLabel.lineBreakMode = .ByWordWrapping
      noMemesLabel.numberOfLines = 3
      noMemesLabel.textAlignment = .Center

      noMemesFooter.addSubview(noMemesLabel)
      
      return  noMemesFooter
    }
    
    return nil
  }
  
  override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return memes.count == 0 ? tableView.bounds.height : 0
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseIdentifiers.MemesTableView.memeTableCell, forIndexPath: indexPath) as! MemeListTableViewCell
    let meme = memes[indexPath.row]
    cell.memeImageView.image = meme.memedImage
    cell.memeTextView.text = "\(meme.topText + ", " + meme.bottomText)"
    
    return cell
  }
  
  // MARK: - Table view delegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier(Constants.Segues.memeDetail, sender: indexPath)
  }
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let identifier = segue.identifier else {
      return
    }
    
    switch identifier {
    case Constants.Segues.memeDetail:
      if let detailController = segue.destinationViewController as? MeMeDetailViewController, indexPath = sender as? NSIndexPath {
        detailController.meme = memes[indexPath.row]
      }
    default:
      return
    }
  }
}
