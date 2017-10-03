//
//  DetailViewController.swift
//  iOSTestProject
//
//  Created by Alyssa on 9/26/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

class DetailView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var titleText: String?
    var dateText: String?
    var contentText: String?
    var LargeImageArray = [String]()
    var ImageArray = [UIImage]()
   
    @IBOutlet var bigTitle: UILabel!
    @IBOutlet var bigDate: UILabel!
    @IBOutlet var bigContent: UILabel!
    @IBOutlet weak var modeBtn: UIButton!
   
    
    
    var isHarleyRed:Bool = true
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
        bigTitle.textColor = textColor
        bigDate.textColor = textColor
        bigContent.textColor = textColor
        navigationController?.navigationBar.barTintColor = color
        self.view.backgroundColor = color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]
        UserDefaults.standard.set(mode, forKey: "mode")
        
        
    }
    
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
        createImageArray()
        // Do any additional setup after loading the view.
    }

    func createImageArray() {
        //let imageView = UIImageView()
        
        for i in 0..<LargeImageArray.count {
            
            let imgUrl = LargeImageArray[i]
            let url = URL(string: imgUrl)
            
            
            if let imageData: NSData = NSData(contentsOf: url!) {
            self.ImageArray.append(UIImage(data: imageData as Data)!)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LargeImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.backgroundColor = UIColor.clear
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CollectionViewCell
        cell.cellImageView.image = ImageArray[indexPath.row]
                return cell
            }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedObject = ImageArray[indexPath.row]
        self.performSegue(withIdentifier: "fullImage", sender: selectedObject)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullImage" {
            
            let currentCell = sender
            let currentImage = currentCell
            let fullImage = segue.destination as! FullImageViewController
            
            fullImage.isHarleyRed = isHarleyRed
            fullImage.fullImage = currentImage as! UIImage
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    }


