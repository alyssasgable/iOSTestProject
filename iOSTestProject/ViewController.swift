//
//  ViewController.swift
//  iOSTestProject
//
//  Created by Christina Holmes on 1/26/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableObjects = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use this array to build your test project
        tableObjects = AppDelegate().downloadArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

