//
//  CVAAVPlayerViewManager.m
//  CVAReferenceApp
//
//  Created by Butchi peddi on 23/08/19.
//  Copyright © 2019 Conviva. All rights reserved.
//

#import "CVAAVPlayerViewManager.h"


#if TARGET_OS_TV
    #import "CVAReferenceApp_tvOS-Swift.h"
    #import <ConvivaIntegrationRefKit_tvOS/ConvivaIntegrationRefKit_tvOS.h>
#else TARGET_OS_IOS
    #import "CVAReferenceApp-Swift.h"
    #import <ConvivaIntegrationRefKit/ConvivaIntegrationRefKit-Swift.h>
#endif


@interface CVAPlayerViewManager()<CVAPlayerContentViewProvider>

@property (nonatomic,readwrite) UIView *avPlayerView;

@end
@implementation CVAPlayerViewManager

RCT_EXPORT_MODULE(CVAPlayerView)

- (UIView *)view
{
  return self.avPlayerView = [[CVAAVPlayerView alloc] init];
                              
}

- (UIView * _Nonnull)playerContentView {
  
  CGRect screenRect = UIScreen.mainScreen.bounds;
  CGFloat width = screenRect.size.width;
  CGFloat height = screenRect.size.height;
  
  if(width < height) {
    screenRect.size.width = height;
    screenRect.size.height = width;
  }
  
  self.avPlayerView.frame = screenRect;
  return self.avPlayerView;
}

@end
