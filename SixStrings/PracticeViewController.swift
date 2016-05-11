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
        
        //
        stageLabel.text = String(user.stage)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

