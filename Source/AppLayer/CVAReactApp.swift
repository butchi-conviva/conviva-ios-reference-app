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

@objc public final class CVAReactApp: NSObject {
  
  @objc public static let shared:CVAReactApp = CVAReactApp();
  @objc public  var reactBridge:RCTBridge? = nil;
  @objc public  var playerModule:CVAPlayerBridge? = nil;
  
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
    
    self.playerModule = bridge.module(for: CVAPlayerBridge.self) as? CVAPlayerBridge;
    let eventEmitter = bridge.module(for: CVAPlayerEventEmitter.self) as? CVAPlayerEventEmitter;
    
    let avPlayer = CVAAVPlayer();
    let googleIMAHandler = CVAGoogleIMAHandler();
    
    let playerViewMgr = self.reactBridge?.module(forName: "CVAPlayerView") as! CVAPlayerViewManager;
    
    let playerEventManager =  CVAPlayerEventManager(eventEmitter:eventEmitter!);
    let playerEventsManager = CVAPlayerEventsManager()
    let adEventManager = CVAAdsEventsManager()
    
    let playerManager = CVAPlayerManager(playerWithCmdHandler : avPlayer,
                                         adCommandHandler     : googleIMAHandler,
                                         playerEventManager   : playerEventManager,
                                         playerContentViewProvider:playerViewMgr as! CVAPlayerContentViewProvider,
                                         playerMgr: playerEventsManager, adMgr: adEventManager);
    
    if let _ = playerModule {
      playerModule?.reactBridge = self.reactBridge;
      playerModule!.registerHandler(playerManager);
      status = true;
    }
    
    return status;
  }
}

extension CVAReactApp : RCTBridgeDelegate {
  
  public func  sourceURL(for bridge: RCTBridge!) -> URL! {
    
    let url:URL?;
    
    #if DEBUG
      url = RCTBundleURLProvider.sharedSettings()?.jsBundleURL(forBundleRoot: "index", fallbackResource: nil);
    #else
      url = Bundle.main.url(forResource: "main", withExtension: "jsbundle");
    #endif
    
    return url;
  }
}
