//
//  CVAAVPlayerViewManager.h
//  CVAReferenceApp
//
//  Created by Butchi peddi on 23/08/19.
//  Copyright © 2019 Conviva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface CVAPlayerViewManager : RCTViewManager

@property (nonatomic,readonly) UIView *avPlayerView;

@end

NS_ASSUME_NONNULL_END
