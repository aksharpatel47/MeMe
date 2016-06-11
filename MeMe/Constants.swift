//
//  Constants.swift
//  MeMe
//
//  Created by Akshar Patel on 28/05/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
  
  struct Segues {
    static let selectFont = "selectFont"
    static let memeDetail = "memeDetail"
    static let editMeme = "editMeme"
  }
  
  struct Events {
    static let fontChanged = "fontChanged"
  }
  
  struct Colors {
    static let pink = UIColor(red: 1.0, green: 0.8, blue: 0.82, alpha: 1.0)
    static let grey = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1.0)
  }
  
  struct CellReuseIdentifiers {
    struct SettingsTable {
      static let selectFontCell = "selectFontCell"
      static let setImageCropPreferenceCell = "setImageCropPreferenceCell"
    }
    
    struct FontsTable {
      static let fontCell = "fontCell"
    }
    
    struct MemesTableView {
      static let memeTableCell = "memeTableCell"
    }
    
    struct MemesCollectionView {
      static let memeCollectionCell = "memeCollectionCell"
    }
  }
  
  struct OfflineKeys {
    static let imageCropPreference = "imageCropPreference"
    static let fontToUse = "fontToUse"
  }
}