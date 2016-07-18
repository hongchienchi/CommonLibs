//
//  UIView+Common.h
//  
//
//  Created by CC Cooper on 5/12/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

@property (strong, nonatomic) NSMutableArray *storedConstrains;

- (void)setFrameSize:(CGSize)size;
- (void)setFrameHeight:(CGFloat)height;
- (void)setFrameWidth:(CGFloat)width;

- (void)setFrameOrigin:(CGPoint)origin;
- (void)setFrameXOrigin:(CGFloat)xOrigin;
- (void)setFrameYOrigin:(CGFloat)yOrigin;


- (void)setMaxX:(CGFloat)xValue;

- (CGRect)frameForBorderWithSize:(CGFloat)size;

- (void)centerVerticallyInSuperviewWithXOrigin:(CGFloat)xOrigin;
- (void)centerHorizontallyInSuperviewWithYOrigin:(CGFloat)yOrigin;
- (void)centerInSuperview;
- (void)centerInSuperviewWithOffset:(CGPoint)offset;

// these are easier to code than the clunky CGRectGet*() functions
- (CGFloat) width;
- (CGFloat) height;
- (CGFloat) minx;
- (CGFloat) maxx;
- (CGFloat) miny;
- (CGFloat) maxy;
- (CGSize) frameSize;

- (void) setBackgroundGradientColorWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;
- (void) setBackgroundGradientColorWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor startPoint:(CGPoint) startPoint endPoint:(CGPoint)endPoint;
@end

@interface UIView (XibHelper)

@property (nonatomic, strong) UIView *xibView;

- (void) xibSetup;
@end
