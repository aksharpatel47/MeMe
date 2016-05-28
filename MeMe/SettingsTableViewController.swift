//
//  SettingsTableViewController.swift
//  MeMe
//
//  Created by Akshar Patel on 28/05/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit

class ImageCropPreferenceTableViewCell: UITableViewCell {
  
  @IBOutlet weak var imageCropPreferenceSwitch: UISwitch!
  
  @IBAction func imageCropPreferenceChanged(sender: UISwitch) {
    NSUserDefaults.standardUserDefaults().setBool(sender.on, forKey: Constants.OfflineKeys.imageCropPreference)
  }
}

class SettingsTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.clearsSelectionOnViewWillAppear = true
    tableView.tableFooterView = UIView()
    subscribeToFontChangeNotification()
  }
  
  deinit {
    unsubscribeFromFontChangeNotification()
  }
  
  func subscribeToFontChangeNotification() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(fontChanged(_:)), name: Constants.Events.fontChanged, object: nil)
  }
  
  func unsubscribeFromFontChangeNotification() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: Constants.Events.fontChanged, object: nil)
  }
  
  func fontChanged(notification: NSNotification) {
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseIdentifiers.SettingsTable.selectFontCell, forIndexPath: indexPath)
      cell.detailTextLabel?.text = NSUserDefaults.standardUserDefaults().stringForKey(Constants.OfflineKeys.fontToUse)
      return cell
    case 1:
      let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseIdentifiers.SettingsTable.setImageCropPreferenceCell, forIndexPath: indexPath) as! ImageCropPreferenceTableViewCell
      cell.imageCropPreferenceSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey(Constants.OfflineKeys.imageCropPreference)
      return cell
    default:
      return UITableViewCell()
    }
  }
  
  // MARK: - Table view delegate
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if indexPath.row == 0 {
      performSegueWithIdentifier(Constants.Segues.selectFont, sender: nil)
    }
  }
  
  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == Constants.Segues.selectFont {
      if let selectFontController = segue.destinationViewController as? SelectFontViewController {
        selectFontController.currentFont = NSUserDefaults.standardUserDefaults().stringForKey(Constants.OfflineKeys.fontToUse)!
      }
    }
  }
}
