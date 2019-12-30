//
//  TvOSSliderEvents.swift
//  CVAReferenceApp-tvOS
//
//  Created by Butchi peddi on 30/12/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

@objc public protocol TvOSSliderEvents {
  func onSeekStart(value:Float);
  func onSeekValueChange(value:Float);
  func onSeekEnd(value:Float);
}
