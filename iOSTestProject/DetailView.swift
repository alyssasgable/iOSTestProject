//
//  DetailViewController.swift
//  iOSTestProject
//
//  Created by Alyssa on 9/26/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

class DetailView: UIViewController {
    
    @IBOutlet weak var modeBtn: UIButton!
    var isHarleyRed:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func modeBtn(_ sender: Any) {
        buttonPressed(bool: !isHarleyRed)
        
    }
    
    
    func buttonPressed(bool: Bool) {
        isHarleyRed = bool
        
        let image = bool ? #imageLiteral(resourceName: "harleylight") : #imageLiteral(resourceName: "harleydark")
        let color = bool ? UIColor.white : UIColor.black
        let textColor = bool ? UIColor.black : UIColor.white
        let mode = bool ? false : true
        
        modeBtn.setImage(image, for: .normal)
        navigationController?.navigationBar.barTintColor = color
        self.view.backgroundColor = color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]
        UserDefaults.standard.set(mode, forKey: "mode")
        
        
    }
    }
