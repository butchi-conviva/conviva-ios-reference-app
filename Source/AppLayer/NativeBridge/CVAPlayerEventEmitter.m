//
//  CVAPlayerEventEmitter.m
//  CVAReferenceApp
//
//  Created by Butchi peddi on 04/09/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(CVAPlayerEventEmitter, RCTEventEmitter)
RCT_EXTERN_METHOD(supportedEvents)
RCT_EXTERN_METHOD(startObserving)
RCT_EXTERN_METHOD(stopObserving)
RCT_EXTERN_METHOD(sendEvent)
@end
