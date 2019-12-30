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

NSString *const kEventSeekStart = @"seekStart";
NSString *const kEventSeekValueChange = @"seekValueChange";
NSString *const kEventSeekEnd = @"seekEnd";

@interface CVASliderViewManager()<TvOSSliderEvents>

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
  sliderView.eventDelegate = self;
  self.sliderView = sliderView;
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveProgressNotification:) name:@"PlaybackProgress" object:nil];
  
  return self.sliderView;
                              
}

- (void)onSeekStartWithValue:(float)value {
   
  //NSLog(@"TvOSSlider:: onSeekStartWithValue");
  
  [self handleSeekEvent:kEventSeekStart value:value];
}

- (void)onSeekValueChangeWithValue:(float)value {
  
   //NSLog(@"TvOSSlider:: onSeekValueChangeWithValue");
  
  [self handleSeekEvent:kEventSeekValueChange value:value];
}

- (void)onSeekEndWithValue:(float)value {
  
   //NSLog(@"TvOSSlider:: onSeekEndWithValue");
  
  [self handleSeekEvent:kEventSeekEnd value:value];
}

-(void) handleSeekEvent:(NSString*)event value:(float)value {
  
  CVAReactApp *reactApp = [CVAReactApp shared];
  [reactApp.playerModule handleEvent:event info:@{@"value":[NSNumber numberWithFloat:value]}];
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
