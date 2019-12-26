//
//  CVAAVPlayerViewManager.m
//  CVAReferenceApp
//
//  Created by Butchi peddi on 23/08/19.
//  Copyright © 2019 Conviva. All rights reserved.
//

#import "CVASliderViewManager.h"
#if TARGET_OS_TV
    #import "CVAReferenceApp_tvOS-Swift.h"
    #import <ConvivaIntegrationRefKit_tvOS/ConvivaIntegrationRefKit_tvOS.h>
#else TARGET_OS_IOS
    #import "CVAReferenceApp-Swift.h"
    #import <ConvivaIntegrationRefKit/ConvivaIntegrationRefKit-Swift.h>
#endif

@interface CVASliderViewManager()

@property (nonatomic,readwrite) UIView *sliderView;

@end
@implementation CVASliderViewManager

RCT_EXPORT_MODULE(CVASliderView)

- (instancetype)init
{
  self = [super init];
  if (self) {
   
  }
  return self;
}

- (UIView *)view
{
  TvOSSlider *sliderView = [[TvOSSlider alloc] init];
  
  sliderView.minimumValue = 0;
  sliderView.maximumValue = 1;
  sliderView.isContinuous = false;
  
  sliderView.minimumTrackTintColor = UIColor.redColor;
  self.sliderView = sliderView;
  
  [sliderView addTarget:self action:@selector(onSliderValueChange:) forControlEvents:UIControlEventValueChanged];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveProgressNotification:) name:@"PlaybackProgress" object:nil];
  
  return self.sliderView;
                              
}

- (void) onSliderValueChange:(TvOSSlider*) slider {
  
  CVAReactApp *reactApp = [CVAReactApp shared];
  float value = ((TvOSSlider*)self.sliderView).value;
  [reactApp.playerModule handleEvent:@"seek" info:@{@"value":[NSNumber numberWithFloat:value]}];
                                                    
}


- (void) receiveProgressNotification:(NSNotification *) notification {

      NSDictionary *userInfo = notification.userInfo;
      NSNumber *progress = userInfo[@"progress"];
      TvOSSlider *sliderView = (TvOSSlider*)self.sliderView;

      [sliderView setValue:progress.floatValue];
    }

- (void)dealloc {
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
