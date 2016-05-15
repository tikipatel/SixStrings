//
//  SixStringsViewControllerBaseClass.swift
//  SixStrings
//
//  Created by sean on 5/11/16.
//  Copyright © 2016 Sean Johnsen. All rights reserved.
//

import Foundation
import UIKit

class SSTabBarController: UITabBarController {
    func loadUser() -> User {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("user") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! User
        } else {
            return User()
        }
    }
    
    func saveUser(user: User) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "user")
    }
}