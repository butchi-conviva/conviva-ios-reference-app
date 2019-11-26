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
    return [CVAPlayerEvent.onContentLoading.rawValue,
            CVAPlayerEvent.onContentLoadDidFail.rawValue,
            CVAPlayerEvent.onContentPlayDidStart.rawValue,
            CVAPlayerEvent.onContentPlayDidFail.rawValue,
            CVAPlayerEvent.onContentPlayDidPause.rawValue,
            CVAPlayerEvent.onContentPlayDidPlay.rawValue,
            CVAPlayerEvent.onContentPlayDidFinish.rawValue,
            CVAPlayerEvent.onPlayHeadChange.rawValue,
            CVAPlayerEvent.onPlayerStateChange.rawValue,
            CVAPlayerEvent.onAdLoading.rawValue,
            CVAPlayerEvent.onAdLoadDidFail.rawValue,
            CVAPlayerEvent.onAdPlayDidStart.rawValue,
            CVAPlayerEvent.onAdPlayDidFail.rawValue,
            CVAPlayerEvent.onAdPlayDidFinish.rawValue];
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
  
  override open static func requiresMainQueueSetup() -> Bool {
    return true;
  }
}


extension CVAPlayerEventEmitter : CVAPlayerEventNotifier {
  
  public func sendEvent(event: CVAPlayerEvent, info: [AnyHashable : Any]?) {
    self.sendEvent(withName: event.rawValue, body: info);
  }
}


