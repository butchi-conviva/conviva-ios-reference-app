//
//  CVAPlaybackBridge.h
//  CVAReferenceApp
//
//  Created by Butchi peddi on 22/08/19.
//  Copyright © 2019 Conviva. All rights reserved.
//


#import <React/RCTBridgeModule.h>
#import "CVAPlayerHandler.h"

@interface CVAPlayerBridge : NSObject<RCTBridgeModule>

@property(nonatomic,assign) RCTBridge *reactBridge;

-(void) registerHandler:(CVAPlayerHandler)playerHandler;

-(void) unRegisterHandler:(CVAPlayerHandler)playerHandler;

-(void) handleEvent:(NSString *)eventName info:(NSDictionary *)info;

@end
