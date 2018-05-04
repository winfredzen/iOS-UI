//
//  CustomView.m
//  NestedScrollViewTest
//
//  Created by 王振 on 2018/5/4.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "CustomView.h"

@interface CustomView()

@property (nonatomic, strong) UILabel *textLbl;

@end


@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame backgroudColor:(UIColor *)bgColor text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = bgColor;
        
        self.textLbl.text = text;
        [self addSubview:self.textLbl];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLbl.frame = CGRectMake(0, 40, CGRectGetWidth(self.frame), 40);
}

- (UILabel *)textLbl
{
    if (!_textLbl) {
        _textLbl = [[UILabel alloc] init];
        [_textLbl setFont:[UIFont boldSystemFontOfSize:25]];
        [_textLbl setTextColor:[UIColor blackColor]];
        [_textLbl setTextAlignment:NSTextAlignmentCenter];
        [_textLbl setBackgroundColor:[UIColor clearColor]];
    }
    return _textLbl;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
