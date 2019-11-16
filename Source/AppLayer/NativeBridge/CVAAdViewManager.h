//
//  CVAAdViewManager.h
//  CVAReferenceApp
//
//  Created by Gaurav Tiwari on 14/11/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVAAdViewManager : RCTViewManager

@property (nonatomic,readonly) UIView *adPlayerView;

@end

NS_ASSUME_NONNULL_END
