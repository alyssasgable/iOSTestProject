//
//  ViewController.swift
//  iOSTestProject
//
//  Created by Christina Holmes on 1/26/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var modeBtn: UIButton!
    var tableObjects = [[String: Any]]()
    
    
    //@IBOutlet weak var darkHarley: UIButton!
    var isHarleyRed:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use this array to build your test project
        tableObjects = AppDelegate().downloadArray()
        
        
    }
    // Dark and Light Mode Function
    @IBAction func modeBtn(_ sender: Any) {
        buttonPressed(bool: !isHarleyRed)
    }
    
    
    func buttonPressed(bool: Bool) {
        isHarleyRed = bool
        
        let image = bool ? #imageLiteral(resourceName: "harleylight") : #imageLiteral(resourceName: "harleydark")
        let color = bool ? UIColor.white : UIColor.black
        let textColor = bool ? UIColor.black : UIColor.white
        
        modeBtn.setImage(image, for: .normal)
        navigationController?.navigationBar.barTintColor = color
        tableView.backgroundColor = color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableObjects.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        
        let tableObjects = self.tableObjects[indexPath.row]

        cell.title?.text = tableObjects["title"] as? String
        cell.epoch?.text = tableObjects["epoch"] as? String
        return cell
    }
}

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var epoch: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

    






