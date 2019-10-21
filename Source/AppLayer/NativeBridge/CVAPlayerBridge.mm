//
//  CVAPlayerBridge.mm
//  CVAReferenceApp
//
//  Created by Butchi peddi on 22/08/19.
//  Copyright © 2019 Conviva. All rights reserved.
//

#import "CVAPlayerBridge.h"
#import <React/RCTLog.h>

#if TARGET_OS_TV
    #import "CVAReferenceApp_tvOS-Swift.h"
#else TARGET_OS_IOS
    #import "CVAReferenceApp-Swift.h"
#endif

@interface CVAPlayerBridge()

@property (nonatomic,strong) CVAPlayerHandler playerHandler;

@end

@implementation CVAPlayerBridge

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(handleEvent:(NSString *)eventName info:(NSDictionary *)info)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", eventName, info);
  
  dispatch_async(dispatch_get_main_queue(),^{
    
    [self.playerHandler handleEvent:eventName info:info];
    
  });
}

-(void) registerHandler:(CVAPlayerHandler)playerHandler {
  
  self.playerHandler = playerHandler;
  
}

-(void) unRegisterHandler:(CVAPlayerHandler)playerHandler {
  
  if (playerHandler == self.playerHandler) {
    self.playerHandler = nil;
  }
  else {
    NSLog(@"Mismatch. Do not do anything...");
  }

}
@end
