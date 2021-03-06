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
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var isHarleyRed:Bool = true
    
    struct cellObject {
        var passedTitle: String?
        var passedContent: String?
        var passedDate: String?
        var passedImageArray = [String]()
    }
    
    var cellObjects = [cellObject]()
    
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
        let background = bool ? UIImageView(image: #imageLiteral(resourceName: "lightBackground")) : UIImageView(image: #imageLiteral(resourceName: "darkBackground"))
        let color = bool ? UIColor.white : UIColor.black
        let textColor = bool ? UIColor.black : UIColor.white
        let mode = bool ? false : true
        
        modeBtn.setImage(image, for: .normal)
        navigationController?.navigationBar.barTintColor = color
        tableView.backgroundView = background as UIView
        UserDefaults.standard.set(mode, forKey: "mode")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:("buttonPressed")), object: textColor)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]
        
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        var shownIndexes : [IndexPath] = []
        
        if (shownIndexes.contains(indexPath) == false) {
            shownIndexes.append(indexPath)
            
            cell.transform = CGAffineTransform(translationX: 0, y: 250)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.alpha = 0
            
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.5)
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            UIView.commitAnimations()
        }
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
        
        let contentString = tableObjects["content"] as? String
    
        let title = tableObjects["title"] as? String
        cell.title?.text = title
        
        //Date converter
        let epoch = tableObjects["epoch"] as? Int

        let date = NSDate(timeIntervalSince1970: (TimeInterval((epoch)!)))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        let convertedDate = dayTimePeriodFormatter.string(from: date as Date)
        
        
        cell.date?.text = convertedDate
        
        let convertedString = contentString?.html2String
        cell.content?.text = convertedString
       
        let imagesArray = tableObjects["images"] as! [[String:String]]
        var smallImageArray = [String]()
        var largeImageArray = [String]()
        
    
        if imagesArray.count != 0 {
            for imageObject in imagesArray {
                smallImageArray.append(imageObject["small"]!)
                largeImageArray.append(imageObject["large"]!)
            }

            cell.img.downloadedFrom(link: smallImageArray[0])
    
        } else if imagesArray.isEmpty {
            cell.img.image = nil
        }
        //Changes color of text
        var colorOfText = UIColor.black
        if UserDefaults.standard.bool(forKey: "mode") {
            
            colorOfText = UIColor.white
            
        }
        cell.title?.textColor = colorOfText
        cell.date?.textColor = colorOfText
        cell.content?.textColor = colorOfText
        
        cellObjects.append(cellObject(passedTitle: title, passedContent: convertedString, passedDate: convertedDate, passedImageArray: largeImageArray))
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let currentCell = tableView.cellForRow(at: indexPath)!
       
        let selectedObject = cellObjects[indexPath.row]
        self.performSegue(withIdentifier: "showDetail", sender: selectedObject)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let currentCell = sender as! cellObject
            let destVC = segue.destination as! DetailView
            
            destVC.isHarleyRed = isHarleyRed
            destVC.titleText = currentCell.passedTitle
            destVC.dateText = currentCell.passedDate
            destVC.contentText  = currentCell.passedContent
            destVC.LargeImageArray = currentCell.passedImageArray
        
        }
    }
  
}

 extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
    






