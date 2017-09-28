//
//  AppDelegate.swift
//  iOSTestProject
//
//  Created by Christina Holmes on 1/26/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    public var feedArray = [[String: Any]]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        downloadArray()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func downloadArray() {
        let requestURL: URL = URL(string: "https://apps.myocv.com/feed/blog/a12722222/ipsumList")!
        let urlRequest: URLRequest = URLRequest(url: requestURL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Download correctly")
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:AnyObject]] else {
                        return
                    }
                    for object in json {
                        let title = object["title"] as? String ?? ""
                        let date = object["date"] as? [String: Int] ?? [:]
                        var epoch = 0
                        if date != [:] {
                            epoch = date["sec"] ?? 0
                        }
                        let content = object["content"] as? String ?? ""
                        let images = object["images"] as? [[String:String]] ?? []
                        
                        self.feedArray.append(["title": title, "epoch": epoch, "content":content, "images":images])
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:("finishedDownload")), object: self.feedArray)
                } catch {
                    print("Error downloading JSON")
                }
            }
        }
        task.resume()
        
    }
}

