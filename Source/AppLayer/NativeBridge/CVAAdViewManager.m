//
//  CVAAdViewManager.m
//  CVAReferenceApp
//
//  Created by Gaurav Tiwari on 14/11/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "CVAAdViewManager.h"

#if TARGET_OS_TV
#import "CVAReferenceApp_tvOS-Swift.h"
#import <ConvivaIntegrationRefKit_tvOS/ConvivaIntegrationRefKit_tvOS.h>
#else
#import "CVAReferenceApp-Swift.h"
#import <ConvivaIntegrationRefKit/ConvivaIntegrationRefKit-Swift.h>
#endif

@interface CVAAdViewManager() <CVAAdViewProvider>

@property (nonatomic,readwrite) UIView *adPlayerView;

@end

@implementation CVAAdViewManager

RCT_EXPORT_MODULE(CVAAdView)

- (UIView *) view {
  return self.adPlayerView = [[CVAAdView alloc] init];
}

- (UIView * _Nonnull) adView {
  
  CGRect screenRect = UIScreen.mainScreen.bounds;
  CGFloat width = screenRect.size.width;
  CGFloat height = screenRect.size.height;
  
  if(width < height) {
    screenRect.size.width = height;
    screenRect.size.height = width;
  }
  
  self.adPlayerView.frame = screenRect;
  return self.adPlayerView;
}

@end
