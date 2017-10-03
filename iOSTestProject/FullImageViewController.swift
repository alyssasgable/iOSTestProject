//
//  FullImageViewController.swift
//  iOSTestProject
//
//  Created by Alyssa on 10/3/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var selectedImage: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var Background: UIView!
    
    var fullImage: UIImage!
    var isHarleyRed:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isHarleyRed == true {
            navigationController?.navigationBar.barTintColor = UIColor.white
            scrollView.backgroundColor = UIColor.clear
            Background.backgroundColor = UIColor.clear
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "lightBackground"))
        } else {
            navigationController?.navigationBar.barTintColor = UIColor.black
            scrollView.backgroundColor = UIColor.clear
            Background.backgroundColor = UIColor.clear
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "darkBackground"))
        }
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        selectedImage.image = fullImage
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.selectedImage
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
