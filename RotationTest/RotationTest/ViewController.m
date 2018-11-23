//
//  ViewController.m
//  RotationTest
//
//  Created by 王振 on 2018/11/23.
//  Copyright © 2018 wz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingConstraint;

- (IBAction)rotate:(id)sender;

@property (assign, nonatomic, getter=isFullScreen) BOOL fullScreen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.containerView.autoresizesSubviews = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.contentView.frame = CGRectInset(self.containerView.frame, 10, 10);

    
}


- (IBAction)rotate:(id)sender {
    
    self.fullScreen = YES;
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    
    self.containerView.transform = [self getTransformRotationAngle:UIInterfaceOrientationLandscapeRight];
    
    //self.heightConstraint.constant = CGRectGetWidth(self.view.frame);
    
    self.containerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    //[self.containerView setNeedsLayout];
    
    self.contentView.frame = CGRectInset(self.containerView.frame, 10, 10);
    
    self.contentView.frame = [self.contentView convertRect:self.contentView.frame toView:self.containerView];
    
    
    
    //[self.contentView setNeedsUpdateConstraints];
    
    
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
    
    //[UIViewController attemptRotationToDeviceOrientation];


    
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
//    if (self.isFullScreen) {
//
//
//        self.containerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
//
//        self.contentView.frame = CGRectInset(self.containerView.frame, 10, 10);
//
//    }
    
}


- (CGAffineTransform)getTransformRotationAngle:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}

//旋转状态栏必须重写这个方法
- (BOOL)shouldAutorotate {
    
    return NO;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    
//    if (self.isFullScreen) {
//        return UIInterfaceOrientationLandscapeRight;
//    }
//    return UIInterfaceOrientationPortrait;
//    
//}

@end
