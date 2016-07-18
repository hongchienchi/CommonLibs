//
//  UIColor+Common.h
//  
//
//  Created by CC Cooper on 5/12/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Common)

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) CGFloat white;
@property (nonatomic, readonly) UInt32 rgbHex;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;

+ (UIColor*) colorWithRGBHex:(UInt32) hex;
+ (UIColor*) colorWithRGBAHex:(UInt32) rgba;

// creates a UIColor object based on the hex string passed in. This does not use a cache
+ (UIColor*) colorWithHexString:(NSString *)hexString;

// creates a UIColor object based on the hex string passed in. This uses a cache
+ (UIColor*) cachedColorWithHexKey:(NSString*) hexKey;

// returns a string that looks like @"xxxxxx" (no alpha) which can be used in +colorWithHexString:
- (NSString*) hexStringFromColor;

// returns @"{rr, gg, bb, aa}"
- (NSString*) stringFromColor;

// XcodeColors support
//
// returns a string compatible with XcodeColors for the current color. This will return @"\033[fgr,g,b;" where r, g, and b come from the current color
- (NSString*) fg;
+ (NSString*) resetfg;

- (NSString*) bg;
+ (NSString*) resetbg;

@end
