//
//  ViewController.m
//  NestedScrollViewTest
//
//  Created by 王振 on 2018/5/4.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIScrollView *nestScrollView;

@property (nonatomic, strong) CustomView *lView;

@property (nonatomic, strong) CustomView *cView;

@property (nonatomic, strong) CustomView *rView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self.view addSubview:self.scrollView];
    
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    _lView = [self createCustomViewWithPosition:rect bgColor:[UIColor redColor] text:@"A"];
    [self.scrollView addSubview:_lView];
    
    rect = CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    _cView = [self createCustomViewWithPosition:rect bgColor:[UIColor yellowColor] text:@"B"];
    [self.scrollView addSubview:_cView];
    
    rect = CGRectMake(CGRectGetWidth(self.scrollView.frame) * 2, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    _rView = [self createCustomViewWithPosition:rect bgColor:[UIColor blueColor] text:@"C"];
    [self.scrollView addSubview:_rView];
    
    
    [_cView addSubview:self.nestScrollView];

    rect = CGRectMake(0, 0, CGRectGetWidth(self.nestScrollView.frame), CGRectGetHeight(self.nestScrollView.frame));
    CustomView *customView = [self createCustomViewWithPosition:rect bgColor:[UIColor greenColor] text:@"1"];
    [self.nestScrollView addSubview:customView];

    rect = CGRectMake(CGRectGetWidth(self.nestScrollView.frame), 0, CGRectGetWidth(self.nestScrollView.frame), CGRectGetHeight(self.nestScrollView.frame));
    customView = [self createCustomViewWithPosition:rect bgColor:[UIColor grayColor] text:@"2"];
    [self.nestScrollView addSubview:customView];

    rect = CGRectMake(CGRectGetWidth(self.nestScrollView.frame) * 2, 0, CGRectGetWidth(self.nestScrollView.frame), CGRectGetHeight(self.nestScrollView.frame));
    customView = [self createCustomViewWithPosition:rect bgColor:[UIColor orangeColor] text:@"3"];
    [self.nestScrollView addSubview:customView];
    
}

- (CustomView *)createCustomViewWithPosition:(CGRect)position bgColor:(UIColor *)bgColor text:(NSString *)text
{
    CustomView *view = [[CustomView alloc] initWithFrame:position backgroudColor:bgColor text:text];
    return view;
}

#pragma mark - Custom Accessors

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * 3, CGRectGetHeight(self.scrollView.frame));
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIScrollView *)nestScrollView
{
    if (!_nestScrollView) {
        _nestScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(_cView.frame), CGRectGetHeight(_cView.frame)-80)];
        _nestScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.nestScrollView.frame) * 3, CGRectGetHeight(self.nestScrollView.frame));
        _nestScrollView.pagingEnabled = YES;
    }
    return _nestScrollView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
