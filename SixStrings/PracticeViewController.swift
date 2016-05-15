//
//  FirstViewController.swift
//  SixStrings
//
//  Created by sean on 5/10/16.
//  Copyright © 2016 Sean Johnsen. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController {
    //MARK: Properties
    var user = User()
    @IBOutlet weak var stageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load user from NSCoding
//        loadUser()
        updateStageLabel()
    }
    
    func updateStageLabel() {
        stageLabel.text = String(user.stage)
    }
    
    // MARK: Actions
    
    @IBAction func incStage(sender: UIButton) {
        user.incrementStage()
        updateStageLabel()
        saveUser()
    }
    
    // MARK: Utilities
    func loadUser() {
        if let tbc = self.tabBarController as? SSTabBarController {
            self.user = tbc.loadUser()
        }
        user.pic = UIImage(named: "headshot")
    }
    
    func saveUser() {
        if let tbc = self.tabBarController as? SSTabBarController {
            tbc.saveUser(user)
        }
    }
}

