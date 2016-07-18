//
//  DeviceHelper.m
//
//
//  Created by CC Cooper on 5/25/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

#import "DeviceHelper.h"

@implementation DeviceHelper

+ (CGSize) deviceSize
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGSize returnSize = size;
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    BOOL isPortrait = UIDeviceOrientationIsPortrait(orientation);
    
    if (isPortrait) {
        if (size.height > size.width) {
            returnSize = size;
        }
        else{
            returnSize = CGSizeMake(size.height, size.width);
        }
    }
    else{
        if (size.width > size.height) {
            returnSize = size;
        }
        else{
            returnSize = CGSizeMake(size.height, size.width);
        }
    }
    
    
    return returnSize;
}

+ (CGFloat) deviceWidth
{
    return DeviceHelper.deviceSize.width;
}

+ (CGFloat) deviceHeight
{
    return DeviceHelper.deviceSize.height;
}

+ (BOOL) isPhone
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? YES : NO;
}

+ (BOOL) isPad
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? YES : NO;
}

+ (CGFloat) iosVersion
{
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    CGFloat number = [version doubleValue];
    
    return number;
}

+ (BOOL) isPhone4
{
    return [DeviceHelper isPhone] && [DeviceHelper deviceHeight] == 480.0f;
}

+ (BOOL) isPhone5
{
    return [DeviceHelper isPhone] && [DeviceHelper deviceHeight] == 568.0f;
}

+ (BOOL) isPhone6
{
    return [DeviceHelper isPhone] && [DeviceHelper deviceHeight] == 667.0f;
}

+ (BOOL) isPhone6Plus
{
    return [DeviceHelper isPhone] && [DeviceHelper deviceHeight] == 736.0f;
}

@end
