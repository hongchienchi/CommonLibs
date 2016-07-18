//
//  LightboxViewController.h
//  
//
//  Created by CC Cooper on 6/16/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LightboxViewController : UIViewController

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;


-(void)tapDetected:(UIGestureRecognizer *)gestureRecognizer;

@end
