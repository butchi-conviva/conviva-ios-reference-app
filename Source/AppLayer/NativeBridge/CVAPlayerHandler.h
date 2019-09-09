//
//  CVAPlayerHandler.h
//  CVAReferenceApp
//
//  Created by Butchi peddi on 22/08/19.
//  Copyright © 2019 Conviva. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CVAPlayerCmdExecutor <NSObject>

@required
-(void) handleEvent:(NSString*)eventName info:(NSDictionary*)info;

@end

typedef id<CVAPlayerCmdExecutor> CVAPlayerHandler;
