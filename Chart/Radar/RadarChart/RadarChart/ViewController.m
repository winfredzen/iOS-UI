//
//  ViewController.m
//  RadarChart
//
//  Created by 王振 on 2018/5/7.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "ViewController.h"
#import "RadarView.h"
#import "Data.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet RadarView *radarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray<Data *> *dataArray = [NSMutableArray new];
    Data *data = [Data new];
    [data setName:[NSString stringWithFormat:@"name%ld", 0L]];
    [data setValue:.5f];
    [dataArray addObject:data];
    
    for (NSInteger i = 2; i <= 3; i++) {
        Data *data = [Data new];
        [data setName:[NSString stringWithFormat:@"name%ld", i]];
        [data setValue:.2f * i];
        [dataArray addObject:data];
    }
    
    for (NSInteger i = 4; i <= 5; i++) {
        Data *data = [Data new];
        [data setName:[NSString stringWithFormat:@"name%ld", i]];
        [data setValue:.1f * i];
        [dataArray addObject:data];
    }
    
    [_radarView setDataArray:dataArray];
    [_radarView setNeedsDisplay];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
