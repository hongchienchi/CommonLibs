//
//  UIView+Common.m
//  
//
//  Created by CC Cooper on 5/12/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

#import "UIView+Common.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char kStoredConstrainsKey;
static char kXibViewKey;

@implementation UIView (Common)

- (void)setFrameOrigin:(CGPoint)origin {
    CGRect viewFrame = [self frame];
    viewFrame.origin = origin;
    [self setFrame:viewFrame];
}

- (void)setFrameXOrigin:(CGFloat)xOrigin {
    CGRect viewFrame = [self frame];
    viewFrame.origin.x = xOrigin;
    [self setFrame:viewFrame];
}

- (void)setFrameYOrigin:(CGFloat)yOrigin {
    CGRect viewFrame = [self frame];
    viewFrame.origin.y = yOrigin;
    [self setFrame:viewFrame];
}

- (void)setFrameSize:(CGSize)size {
    CGRect viewFrame = [self frame];
    viewFrame.size = size;
    [self setFrame:viewFrame];
}

- (void)setFrameHeight:(CGFloat)height {
    CGRect viewFrame = [self frame];
    viewFrame.size.height = height;
    [self setFrame:viewFrame];
}

- (void)setFrameWidth:(CGFloat)width {
    CGRect viewFrame = [self frame];
    viewFrame.size.width = width;
    [self setFrame:viewFrame];
}

- (void)setMaxX:(CGFloat)xValue {
    CGRect viewFrame = [self frame];
    viewFrame.origin.x = xValue - viewFrame.size.width;
    [self setFrame:viewFrame];
}

- (CGRect)frameForBorderWithSize:(CGFloat)size {
    CGFloat x = [self frame].origin.x - size;
    CGFloat y = [self frame].origin.y - size;
    CGFloat width = [self frame].size.width + (size * 2);
    CGFloat height =  [self frame].size.height + (size * 2);
    
    return CGRectMake(x, y, width, height);
}

- (void)centerVerticallyInSuperviewWithXOrigin:(CGFloat)xOrigin {
    if(nil == [self superview])
        return;
    
    CGRect superviewBounds = [[self superview] bounds];
    CGRect selfFrame = [self frame];
    selfFrame.origin.x = xOrigin;
    selfFrame.origin.y = floor((superviewBounds.size.height - selfFrame.size.height)/2);
    [self setFrame:selfFrame];
}

- (void)centerHorizontallyInSuperviewWithYOrigin:(CGFloat)yOrigin {
    if(nil == [self superview])
        return;
    
    CGRect superviewBounds = [[self superview] bounds];
    CGRect selfFrame = [self frame];
    selfFrame.origin.x = floor((superviewBounds.size.width - selfFrame.size.width)/2);
    selfFrame.origin.y = yOrigin;
    [self setFrame:selfFrame];
}

- (void)centerInSuperview {
    if(nil == [self superview])
        return;
    
    CGRect superviewBounds = [[self superview] bounds];
    CGRect selfFrame = [self frame];
    selfFrame.origin.x = floor((superviewBounds.size.width - selfFrame.size.width)/2);
    selfFrame.origin.y = floor((superviewBounds.size.height - selfFrame.size.height)/2);
    [self setFrame:selfFrame];
}

- (void)centerInSuperviewWithOffset:(CGPoint)offset {
    if(nil == [self superview])
        return;
    
    CGRect superviewBounds = [[self superview] bounds];
    CGRect selfFrame = [self frame];
    selfFrame.origin.x = floor((superviewBounds.size.width - selfFrame.size.width)/2) + offset.x;
    selfFrame.origin.y = floor((superviewBounds.size.height - selfFrame.size.height)/2) + offset.y;
    [self setFrame:selfFrame];
}

- (CGFloat) width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat) height {
    return CGRectGetHeight(self.frame);
}

- (CGFloat) minx {
    return CGRectGetMinX(self.frame);
}

- (CGFloat) maxx {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat) miny {
    return CGRectGetMinY(self.frame);
}

- (CGFloat) maxy {
    return CGRectGetMaxY(self.frame);
}

- (CGSize) frameSize
{
    return self.frame.size;
}



- (void) setBackgroundGradientColorWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor
{
    [self setBackgroundGradientColorWithTopColor:topColor bottomColor:bottomColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
}

- (void) setBackgroundGradientColorWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor startPoint:(CGPoint) startPoint endPoint:(CGPoint)endPoint
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = @[ (id)[topColor CGColor], (id)[bottomColor CGColor]];
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    [self.layer insertSublayer:gradient atIndex:0];
    //use startPoint and endPoint to change direction of gradient (http://stackoverflow.com/a/20387923/2057171)
}

- (id) storedConstrains
{
    NSObject* userInfo = objc_getAssociatedObject(self, &kStoredConstrainsKey);
    return userInfo;
}

- (void)setStoredConstrains:(NSObject*) userInfo
{
    objc_setAssociatedObject(self, &kStoredConstrainsKey, userInfo, OBJC_ASSOCIATION_RETAIN);
}

@end


@implementation UIView (XibHelper)

- (id) xibView
{
    NSObject* xibView = objc_getAssociatedObject(self, &kXibViewKey);
    return xibView;
}

- (void)setXibView:(NSObject*) xibView
{
    objc_setAssociatedObject(self, &kXibViewKey, xibView, OBJC_ASSOCIATION_RETAIN);
}

- (void) xibSetup
{
    self.xibView = [self loadViewFromNib];
    self.xibView.frame = self.bounds;
    self.xibView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.xibView];
}

- (UIView *) loadViewFromNib
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:[NSBundle mainBundle]];
    NSArray *views = [nib instantiateWithOwner:self options:nil];
    UIView *view = [views firstObject];
    return view;
}

@end