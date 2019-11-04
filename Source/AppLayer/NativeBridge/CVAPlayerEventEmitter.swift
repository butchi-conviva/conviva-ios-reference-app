//
//  CVAPlayerEventEmitter.swift
//  CVAReferenceApp
//
//  Created by Butchi peddi on 03/09/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
#if os(iOS)
import ConvivaIntegrationRefKit
#else
import ConvivaIntegrationRefKit_tvOS
#endif

@objc(CVAPlayerEventEmitter)
open class CVAPlayerEventEmitter: RCTEventEmitter {
  
  private var hasListeners:Bool = false;
  
  override open func supportedEvents() -> [String]! {
    return [CVAPlayerEvent.onPlayHeadChange.rawValue,CVAPlayerEvent.onPlayerdidFinishPlaying.rawValue,CVAPlayerEvent.onPlayerdidFailPlaying.rawValue];
  }
  
  override open func startObserving() {
    hasListeners = true;
  }
  
  override open func stopObserving() {
    hasListeners = false;
  }
  
  override open func sendEvent(withName name: String!, body: Any!) {
    if false != hasListeners {
      super.sendEvent(withName: name, body: body);
    }
  }
  
  override public static func requiresMainQueueSetup() -> Bool {
    return true;
  }
}


extension CVAPlayerEventEmitter : CVAPlayerEventNotifier {
  
  public func sendEvent(event: CVAPlayerEvent, info: [AnyHashable : Any]?) {
    self.sendEvent(withName: event.rawValue, body: info);
  }
}


