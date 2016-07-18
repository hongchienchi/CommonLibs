//
//  UIColor+Common.m
//  
//
//  Created by CC Cooper on 5/12/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

#import "UIColor+Common.h"

static NSMutableDictionary* s_colorCache = nil;

@implementation UIColor (basic_support)

+ (UIColor*)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor*) colorWithRGBAHex:(UInt32)rgba {
    CGFloat red = ((rgba & 0xFF000000) >> 24) / 255.0f;
    CGFloat green = ((rgba & 0x00FF0000) >> 16) / 255.0f;
    CGFloat blue = ((rgba & 0x0000FF00) >> 8) / 255.0f;
    CGFloat alpha = (rgba & 0x000000FF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

// utility method, not meant to be public
+ (UIColor*) colorWithHexString:(NSString *)hexString useCached:(BOOL)useCached; {
    // when copying colors from the DigitalColor Meter app, it inserts a '#' character. If it's there, remove it
    if([hexString hasPrefix:@"#"]) {
        hexString = [hexString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }
    
    // add alpha value to it if not there
    NSString* adjustedHexString = hexString;
    if(hexString.length == 6) {
        adjustedHexString = [hexString stringByAppendingString:@"ff"];
    }
    
    if(useCached) {
        if(s_colorCache == nil) {
            s_colorCache = [NSMutableDictionary new];
        }
        
        UIColor *color = [s_colorCache objectForKey:adjustedHexString];
        if(color) {
            // it's in the cache, so return it
            return color;
        } else {
            // not in the cache, so fall through and create the color object. We'll cache it at the end
        }
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:adjustedHexString];
    uint32_t hexNum;
    if(![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    
    // since we already applied the alpha, use the RGBA method
    UIColor* color = [UIColor colorWithRGBAHex:hexNum];
    
    if(useCached) {
        // stick it in the cache for later use
        [s_colorCache setObject:color forKey:adjustedHexString];
    }
    
    return color;
}

+ (UIColor *)colorWithHexString:(NSString*)hexString {
    // for backward compatibility, we retain the old behavior, which is to not use cached colors
    return [self colorWithHexString:hexString useCached:NO];
}

+ (UIColor*) cachedColorWithHexKey:(NSString*) hexKey {
    return [self colorWithHexString:hexKey useCached:YES];
}

#pragma mark - COLOR COMPONENTS

- (CGColorSpaceModel) colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL) canProvideRGBComponents {
    switch(self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (CGFloat) red {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *color = CGColorGetComponents(self.CGColor);
    
    return color[0];
}

- (CGFloat) green {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *color = CGColorGetComponents(self.CGColor);
    
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome)
        return color[0];
    
    return color[1];
}

- (CGFloat) blue {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *color = CGColorGetComponents(self.CGColor);
    
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome)
        return color[0];
    
    return color[2];
}

- (CGFloat) alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (CGFloat) white {
    NSAssert(self.colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *color = CGColorGetComponents(self.CGColor);
    
    return color[0];
}

- (UInt32) rgbHex {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r = self.red;
    CGFloat g = self.green;
    CGFloat b = self.blue;
    
    r = MIN(MAX(r, 0.0f), 1.0f);
    g = MIN(MAX(g, 0.0f), 1.0f);
    b = MIN(MAX(b, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

#pragma mark - STRING CONVERSIONS

- (NSString *)hexStringFromColor {
    return [NSString stringWithFormat:@"%0.6X", (unsigned int)self.rgbHex];
}

- (NSString *)stringFromColor {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -stringFromColor");
    
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
            return [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", self.red, self.green, self.blue, self.alpha];
        case kCGColorSpaceModelMonochrome:
            return [NSString stringWithFormat:@"{%0.3f, %0.3f}", self.white, self.alpha];
        default:
            return nil;
    }
}

#pragma mark - XCODECOLORS SUPPORT

static BOOL s_isColorizationEnabled() {
    static NSNumber* s_cachedValue = nil;
    
    if(s_cachedValue == nil) {
        // is the plugin even available and enabled?
        char *xcode_colors = getenv("XcodeColors");
        s_cachedValue = [NSNumber numberWithBool:(xcode_colors && (strcmp(xcode_colors, "YES") == 0))];
    }
    
    return s_cachedValue.boolValue;
}

// returns a string compatible with XcodeColors for the current color. This will return @"\033[fgr,g,b;" where r, g, and b come from the current color
- (NSString *) fg {
    // is the plugin even available and enabled?
    if(s_isColorizationEnabled()) {
        return [NSString stringWithFormat:@"\033[fg%d,%d,%d;", (int) (self.red*255), (int) (self.green*255), (int) (self.blue*255)];
    }
    
    return @"";
}

+ (NSString *) resetfg {
    if(s_isColorizationEnabled()) {
        return @"\033[fg;";
    }
    
    return @"";
}

- (NSString *) bg {
    if(s_isColorizationEnabled()) {
        return [NSString stringWithFormat:@"\033[bg%d,%d,%d;", (int) (self.red*255), (int) (self.green*255), (int) (self.blue*255)];
    }
    
    return @"";
}

+ (NSString *) resetbg {
    if(s_isColorizationEnabled()) {
        return @"\033[bg;";
    }
    
    return @"";
}

@end
