//
//  CVAReactApp.swift
//  CVAReferenceApp
//
//  Created by Butchi peddi on 11/10/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

#if os(iOS)
import ConvivaIntegrationRefKit
import UIKit
import CoreTelephony
#else
import ConvivaIntegrationRefKit_tvOS
#endif

class CVAReactApp: NSObject {
  
  static let shared:CVAReactApp = CVAReactApp();
  private(set) var reactBridge:RCTBridge? = nil;
  
  private override init() {
    
  }
  
  func setup(launchOptions:[UIApplication.LaunchOptionsKey: Any]?) ->  RCTRootView?{
    
    var rootView:RCTRootView? = nil;
    
    self.reactBridge = RCTBridge(delegate: self as RCTBridgeDelegate, launchOptions: launchOptions);
    
    if let _ = self.reactBridge {
      
      /* Register player handler */
      let _ = self.configureBridge(bridge: self.reactBridge!);
      
      rootView = RCTRootView(bridge: self.reactBridge!, moduleName: "CVAReferenceApp", initialProperties: nil);
      rootView?.backgroundColor = UIColor.white;
      
    }
    
    return rootView;
  }
  
  private func configureBridge(bridge:RCTBridge) -> Bool{
    
    var status:Bool = false;
    
    let playerModule = bridge.module(for: CVAPlayerBridge.self) as? CVAPlayerBridge;
    let eventEmitter = bridge.module(for: CVAPlayerEventEmitter.self) as? CVAPlayerEventEmitter;
    let avPlayer = CVAAVPlayer();
    
    let playerViewMgr = self.reactBridge?.module(forName: "CVAPlayerView") as! CVAPlayerViewManager;
    
    let adViewMgr = self.reactBridge?.module(forName: "CVAAdView") as! CVAAdViewManager;

    let playerEventManager =  CVAPlayerEventManager(eventEmitter:eventEmitter!);
    let playerManager = CVAPlayerManager(playerWithCmdHandler: avPlayer,
                                         playerEventManager:playerEventManager,
                                         playerContentViewProvider:playerViewMgr as! CVAPlayerContentViewProvider, adViewProvider: adViewMgr as!  CVAAdViewProvider);
    
    
    if let _ = playerModule {
      playerModule?.reactBridge = self.reactBridge;
      playerModule!.registerHandler(playerManager);
      status = true;
    }
    
    return status;
  }
}

extension CVAReactApp : RCTBridgeDelegate {
  
  func sourceURL(for bridge: RCTBridge!) -> URL! {
    #if DEBUG
      return RCTBundleURLProvider.sharedSettings()?.jsBundleURL(forBundleRoot: "index", fallbackResource: nil);
    #else
      return Bundle.main.url(forResource: "main", withExtension: "jsbundle");
    #endif
  }
}
