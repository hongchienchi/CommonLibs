//
//  DeviceHelper.h
//
//
//  Created by CC Cooper on 5/25/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceHelper : NSObject

+ (CGSize) deviceSize;

+ (CGFloat) deviceWidth;

+ (CGFloat) deviceHeight;

+ (BOOL) isPhone;

+ (BOOL) isPad;

+ (CGFloat) iosVersion;

+ (BOOL) isPhone4;
+ (BOOL) isPhone5;
+ (BOOL) isPhone6;
+ (BOOL) isPhone6Plus;
@end
