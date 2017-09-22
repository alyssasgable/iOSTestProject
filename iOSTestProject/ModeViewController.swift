//
//  ModeViewController.swift
//  iOSTestProject
//
//  Created by Alyssa on 9/20/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

class ModeViewController: UIViewController {
    
    @IBOutlet var DarkSwitch: UISwitch!
    
    @IBOutlet var LightSwitch: UISwitch!
    
    var DarkisOn = Bool()
    var LightisOn = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let DarkDefault = UserDefaults.standard
        
        DarkisOn = DarkDefault.bool(forKey: "DarkDefault")
        
        let LightDefault = UserDefaults.standard
        
        LightisOn = LightDefault.bool(forKey: "LightDefault")
        
        if (DarkisOn == true) {
            
            DarkSwitch.isOn = true
            LightSwitch.isOn = false
            //run dark theme
            DarkTheme()
        }
        
        if (LightisOn == true) {
            
            DarkSwitch.isOn = false
            LightSwitch.isOn = true
            //run light theme
            LightTheme()
        }
        
    }
    
    func DarkTheme()    //dark colour
    {
        self.view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
    }
    
    func LightTheme()   //light colour
    {
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    

    @IBAction func DarkAction(_ sender: Any)
    {
        DarkSwitch.isOn = true
        LightSwitch.isOn = false
        
        //run dark theme func
        DarkTheme()
        
        let DarkDefault = UserDefaults.standard
        DarkDefault.set(true, forKey: "DarkDefault")
        
        let LightDefault = UserDefaults.standard
        LightDefault.set(false, forKey: "LightDefault")
        
        
    }
    
    @IBAction func LightAction(_ sender: Any)
    {
        DarkSwitch.isOn = false
        LightSwitch.isOn = true
        
        //run light theme func
        LightTheme()
        
        let DarkDefault = UserDefaults.standard
        DarkDefault.set(false, forKey: "DarkDefault")
        
        let LightDefault = UserDefaults.standard
        LightDefault.set(true, forKey: "LightDefault")
        
        
    }
}
