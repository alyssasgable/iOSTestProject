//
//  DetailViewController.swift
//  iOSTestProject
//
//  Created by Alyssa on 9/26/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

class DetailView: UIViewController {
    
    var titleText: String?
    var dateText: String?
    var contentText: String?
    var LargeImageArray = [String]()
    
   
    @IBOutlet var bigTitle: UILabel!
    @IBOutlet var bigDate: UILabel!
    @IBOutlet var bigContent: UILabel!
    @IBOutlet weak var modeBtn: UIButton!

    var isHarleyRed:Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isHarleyRed == false {
            buttonPressed(bool: isHarleyRed)
        }
        if let titleText = titleText {
            bigTitle.text = titleText
            bigDate.text = dateText
            bigContent.text = contentText
            bigContent.sizeToFit()
        }
    }
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
    
    //Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("gallery count : \(self.LargeImageArray.count)")
        return self.LargeImageArray.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        let image = UIImageView()
        cell.addSubview(image)
        image.frame = cell.frame
        image.downloadedFrom(link:LargeImageArray[indexPath.row])
        
//        if let imgUrl = LargeImageArray[indexPath.row] {
//            if let url = URL(string: imgUrl) {
//                cell.cellImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "place holder image"), options: .lowPriority)
//            }
        //}
        return cell
    }
    
    func buttonPressed(bool: Bool) {
        isHarleyRed = bool
        
        let image = bool ? #imageLiteral(resourceName: "harleylight") : #imageLiteral(resourceName: "harleydark")
        let color = bool ? UIColor.white : UIColor.black
        let textColor = bool ? UIColor.black : UIColor.white
        let mode = bool ? false : true
        
        modeBtn.setImage(image, for: .normal)
        bigTitle.textColor = textColor
        bigDate.textColor = textColor
        bigContent.textColor = textColor
        navigationController?.navigationBar.barTintColor = color
        self.view.backgroundColor = color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]
        UserDefaults.standard.set(mode, forKey: "mode")
        
        
    }
    }
