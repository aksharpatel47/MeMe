//
//  SelectFontViewController.swift
//  MeMe
//
//  Created by Akshar Patel on 28/05/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit

class SelectFontViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var fontsTableView: UITableView!
  
  var currentFont = ""
  var filteredFontFamilyList = [String]()
  var fontFamilyList = [String]()
  var fontListDictionary = [String:[String]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for family in UIFont.familyNames().sort() {
      fontFamilyList.append(family)
      fontListDictionary[family] = [String]()
      for font in UIFont.fontNamesForFamilyName(family) {
        fontListDictionary[family]?.append(font)
      }
    }
    
    filteredFontFamilyList = fontFamilyList
  }
}

extension SelectFontViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let family = filteredFontFamilyList[indexPath.section]
    let font = fontListDictionary[family]![indexPath.row]
    currentFont = font
    NSUserDefaults.standardUserDefaults().setObject(currentFont, forKey: Constants.OfflineKeys.fontToUse)
    NSNotificationCenter.defaultCenter().postNotificationName(Constants.Events.fontChanged, object: nil)
    tableView.reloadData()
  }
}

extension SelectFontViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return filteredFontFamilyList.count
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return filteredFontFamilyList[section]
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let family = filteredFontFamilyList[section]
    return fontListDictionary[family]!.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let family = filteredFontFamilyList[indexPath.section]
    let font = fontListDictionary[family]?[indexPath.row]
    
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseIdentifiers.FontsTable.fontCell, forIndexPath: indexPath)
    cell.textLabel?.text = font
    cell.textLabel?.font = UIFont(name: font!, size: 15)
    
    if font == currentFont {
      cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }
    
    return cell
  }
}

extension SelectFontViewController: UISearchBarDelegate {
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      filteredFontFamilyList = fontFamilyList
    } else {
      filteredFontFamilyList = fontFamilyList.filter({ $0.rangeOfString(searchText) != nil })
    }
    
    fontsTableView.reloadData()
  }
  
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
    filteredFontFamilyList = fontFamilyList
    fontsTableView.reloadData()
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}