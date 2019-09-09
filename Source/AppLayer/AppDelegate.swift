//
//  AppDelegate.swift
//  ConvivaAVPlayer
//
//  Created by Butchi peddi on 26/07/19.
//  Copyright © 2019 Butchi peddi. All rights reserved.
//

import UIKit
import ConvivaIntegrationRefKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,RCTBridgeDelegate {

    var window: UIWindow?
    private(set) var reactBridge:RCTBridge? = nil;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
      self.reactBridge = RCTBridge(delegate: self, launchOptions: launchOptions);
      
      if let _ = self.reactBridge {
        
        /* Register player handler */
        let _ = self.setupReactBridge(bridge: self.reactBridge!);
        
        let rootView = RCTRootView(bridge: self.reactBridge!, moduleName: "CVAReferenceApp", initialProperties: nil);
        rootView.backgroundColor = UIColor.white;
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        let rootViewController = UIViewController(nibName: nil, bundle: nil);
        rootViewController.view = rootView;
        self.window?.rootViewController = rootViewController;
        self.window?.makeKeyAndVisible();
        
        return true;
      }
      
      return false;
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
  

  func sourceURL(for bridge: RCTBridge!) -> URL! {
    #if DEBUG
      return RCTBundleURLProvider.sharedSettings()?.jsBundleURL(forBundleRoot: "index", fallbackResource: nil);
    #else
      return Bundle.main.url(forResource: "main", withExtension: "jsbundle");
    #endif
  }
  
  
  func setupReactBridge(bridge:RCTBridge) -> Bool{
  
    var status:Bool = false;
  
    let playerModule = bridge.module(for: CVAPlayerBridge.self) as? CVAPlayerBridge;
    let eventEmitter = bridge.module(for: CVAPlayerEventEmitter.self) as? CVAPlayerEventEmitter;
    let avPlayer = CVAAVPlayer();
    
    
    let playerViewMgr = self.reactBridge?.module(forName: "CVAPlayerView") as! CVAPlayerViewManager;
 
    let playerEventManager =  CVAPlayerEventManager(eventEmitter:eventEmitter!);
    let playerManager = CVAPlayerManager(playerWithCmdHandler: avPlayer,
                                         playerEventManager:playerEventManager,
                                         playerContentViewProvider:playerViewMgr as! CVAPlayerContentViewProvider);
    
    
    if let _ = playerModule {
      playerModule?.reactBridge = self.reactBridge;
      playerModule!.registerHandler(playerManager);
      status = true;
    }
    
    return status;
  }
}

