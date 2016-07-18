//
//  LightboxViewController.m
//  
//
//  Created by CC Cooper on 6/16/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

#import "LightboxViewController.h"

@interface LightboxViewController () <UIGestureRecognizerDelegate>

@end

@implementation LightboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([DeviceHelper isPhone]){
        self.navigationItem.rightBarButtonItem = nil;
    }
    else{
        if (self.parentViewController) {
            [self.parentViewController.view.window addGestureRecognizer:self.tapGesture];
        }
        else {
            [[UIApplication sharedApplication].keyWindow addGestureRecognizer:self.tapGesture];
        }
    }
    
    self.navigationController.view.superview.layer.cornerRadius = 0;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITapGestureRecognizer *) tapGesture
{
    if (_tapGesture == nil) {
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        _tapGesture.cancelsTouchesInView = NO;
        _tapGesture.delegate = self;
    }
    
    return _tapGesture;
}

#pragma mark - UIGestureRecognizerDelegate


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)tapDetected:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint location = [gestureRecognizer locationInView:self.view];
        BOOL inView = [self.view pointInside:location withEvent:nil];
        
        if (!inView) {
            [self.navigationController.view.window removeGestureRecognizer:gestureRecognizer];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
