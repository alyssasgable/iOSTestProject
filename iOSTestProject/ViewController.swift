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
    
    var isHarleyRed:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:("finishedDownload")), object: nil, queue: nil, using: { (notification) in
            
            self.tableObjects = notification.object as! [[String: Any]]
            self.tableView.reloadData()
        })
        
        //Makes sure the last mode chosen appears
        
        if UserDefaults.standard.bool(forKey: "mode") == true {
            buttonPressed(bool: !isHarleyRed)
        } else {
            buttonPressed(bool: isHarleyRed)
        }

        
    }
    // Dark and Light Mode Functions
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
        tableView.backgroundColor = color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]
        UserDefaults.standard.set(mode, forKey: "mode")
        

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
        cell.content?.text = tableObjects["content"] as? String
        cell.img?.image = tableObjects["images"] as? UIImage
        
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

    






