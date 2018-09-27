//
//  ViewController.m
//  ParallaxScrollingWithHeaderStickingAtTop
//
//  Created by 王振 on 2018/9/26.
//  Copyright © 2018 wz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *outerScrollView;

@property (nonatomic, strong) UITableView *innerTableView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *stickView;

//向上 or 向下 滑动
@property (nonatomic, assign) BOOL goingUp;

@property (nonatomic, assign) BOOL childScrollingDownDueToParent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    [self.view addSubview:self.outerScrollView];
    [self.outerScrollView addSubview:self.headerView];
    [self.headerView addSubview:self.stickView];
    [self.outerScrollView addSubview:self.innerTableView];
    
    self.outerScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.innerTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [self.innerTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    return cell;
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%@ translationInView.y = [%f]", [scrollView class], [scrollView.panGestureRecognizer translationInView:scrollView].y);
    
    NSLog(@"%@ contentOffset.y = [%f]", [scrollView class], scrollView.contentOffset.y);
    
    self.goingUp = [scrollView.panGestureRecognizer translationInView:scrollView].y < 0;
    
    //外层scrollView最大偏移量
    CGFloat parentViewMaxContentYOffset = self.outerScrollView.contentSize.height - CGRectGetHeight(self.outerScrollView.frame);
    
    if (self.goingUp) { //向上滚动
        if (scrollView == self.innerTableView) {
            
            NSLog(@"1");
            
            if (self.outerScrollView.contentOffset.y < parentViewMaxContentYOffset) {
                
                CGFloat offsetY = self.innerTableView.contentOffset.y + self.outerScrollView.contentOffset.y;
                
                offsetY = MIN(offsetY, parentViewMaxContentYOffset);
                
                self.outerScrollView.contentOffset = CGPointMake(0, offsetY);
                
                //将innerTableView的contentOffset.y设置为0
                self.innerTableView.contentOffset = CGPointMake(0, 0);
                
            }
        }
        
        if (scrollView == self.outerScrollView) {
//            if (self.outerScrollView.contentOffset.y > parentViewMaxContentYOffset) {
//                CGFloat offsetY = self.outerScrollView.contentOffset.y - parentViewMaxContentYOffset;
//
//                self.innerTableView.contentOffset = CGPointMake(0, offsetY);
//
//                self.outerScrollView.contentOffset = CGPointMake(0, parentViewMaxContentYOffset);
//            }
        }
        
    } else { //向下滑动
        if (scrollView == self.innerTableView) {
            NSLog(@"2");
            if (self.innerTableView.contentOffset.y < 0) {
                CGFloat offsetY = self.outerScrollView.contentOffset.y - fabs(self.innerTableView.contentOffset.y);
                self.outerScrollView.contentOffset = CGPointMake(0, offsetY);
                
                self.innerTableView.contentOffset = CGPointMake(0, 0);
            }
        }
        
        if (scrollView == self.outerScrollView) {
            NSLog(@"3");
            /*
            if (self.innerTableView.contentOffset.y > 0 && self.outerScrollView.contentOffset.y < parentViewMaxContentYOffset) {
                
                self.childScrollingDownDueToParent = YES;
                CGFloat offsetY = self.innerTableView.contentOffset.y - (parentViewMaxContentYOffset - self.outerScrollView.contentOffset.y);
                offsetY = MAX(offsetY, 0);
                self.innerTableView.contentOffset = CGPointMake(0, offsetY);
                self.outerScrollView.contentOffset = CGPointMake(0, parentViewMaxContentYOffset);
                self.childScrollingDownDueToParent = NO;
                
            }
             */
        }
    }
    
}



#pragma mark - Custom Accessors

- (UITableView *)innerTableView {
    
    if (!_innerTableView) {
        CGRect rect = CGRectMake(0, CGRectGetHeight(self.headerView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        _innerTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _innerTableView.delegate = self;
        _innerTableView.dataSource = self;
    }
    return _innerTableView;
    
}


- (UIScrollView *)outerScrollView {
    
    if (!_outerScrollView) {
        _outerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _outerScrollView.backgroundColor = [UIColor yellowColor];
        _outerScrollView.delegate = self;
        _outerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame),
                                                  CGRectGetHeight(self.headerView.frame) + CGRectGetHeight(self.innerTableView.frame));
    }
    return _outerScrollView;
    
}

- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
    
}

- (UIView *)stickView {
    
    if (!_stickView) {
        _stickView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.headerView.frame) - 50, CGRectGetWidth(self.headerView.frame), 50)];
        _stickView.backgroundColor = [UIColor blueColor];
    }
    return _stickView;
    
}

@end
