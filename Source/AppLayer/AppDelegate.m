/**
 * Copyright (c) Conviva, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"


#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "CVAPlayerBridge.h"
#import "CVAReferenceApp-Swift.h"

@interface AppDelegate()
@property (nonatomic,strong,readwrite) RCTBridge *reactBridge;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.reactBridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  
  /* Register player handler */
  [self registerPlayerHandler:self.reactBridge];

  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:self.reactBridge
                                                   moduleName:@"CVAReferenceApp"
                                            initialProperties:nil];

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (BOOL) registerPlayerHandler:(RCTBridge*)bridge {

  BOOL bRet = NO;

  if(nil != bridge){
   
    CVAPlayerBridge *playerModule = [bridge moduleForClass:[CVAPlayerBridge class]];
    CVAPlayerManager *playerManager = [[CVAPlayerManager alloc] init];
    if(nil != playerModule){
      [playerModule registerHandler:playerManager];
      bRet = YES;
    }
   
  }

  return bRet;
}
   
@end
