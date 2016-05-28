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
  }
  
  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseIdentifiers.SettingsTable.setImageCropPreferenceCell, forIndexPath: indexPath) as! ImageCropPreferenceTableViewCell
    cell.imageCropPreferenceSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey(Constants.OfflineKeys.imageCropPreference)
    return cell
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
   if editingStyle == .Delete {
   // Delete the row from the data source
   tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
   } else if editingStyle == .Insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
