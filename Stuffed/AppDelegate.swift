//
//  AppDelegate.swift
//  Stuffed
//
//  Created by Mac Bellingrath on 10/27/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
       
        case .Pad :
            // Use GameBoard
            let storyboard = UIStoryboard(name: "GameBoard", bundle: nil)
            window?.rootViewController = storyboard.instantiateInitialViewController()
            print("Pad")
        case .Phone:
            //Use GamePad
            let storyboard = UIStoryboard(name: "GamePad", bundle: nil)
            window?.rootViewController = storyboard.instantiateInitialViewController()
            
            print("Phone")
        case .TV:
            
            print("TV")
        case .Unspecified:
            print("Unspecified device")
            
        }
     
        
        
        
        
        
        window?.makeKeyAndVisible()
        return true
    }
}

