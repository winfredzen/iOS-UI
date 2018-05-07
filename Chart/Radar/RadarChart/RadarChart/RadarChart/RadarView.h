//
//  RadarView.h
//  getu
//
//  Created by lvlei on 2016/12/29.
//  Copyright © 2016年 getui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+CreateMethods.h"
#import "Consts.h"
#import "Data.h"

@interface RadarView : UIView

@property (strong, nonatomic) NSArray<Data *> *dataArray;

@end
