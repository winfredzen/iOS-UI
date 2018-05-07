//
//  RadarView.m
//  getu
//
//  Created by lvlei on 2016/12/29.
//  Copyright © 2016年 getui. All rights reserved.
//

#import "RadarView.h"

@implementation RadarView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!_dataArray || _dataArray.count == 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat centerX = CGRectGetWidth(self.frame) / 2;
    CGFloat centerY = CGRectGetHeight(self.frame) / 2;
    NSInteger count = _dataArray.count;
    CGFloat unitAngle = 2 * M_PI / count;
    CGFloat maxSideLength = CGRectGetWidth(self.frame) / 4;
    NSInteger polygonCount = PORTRAIT_POLYGON_FILL_COLOR_ARRAY.count;
    CGFloat unitRadius = maxSideLength / polygonCount;
    
    // 绘制多边形
    for (NSInteger i = polygonCount; i >= 1; i--) {
        CGFloat curRadius = unitRadius * i;
        for (NSInteger j = 0; j < count; j++) {
            CGFloat angle = unitAngle * j;
            CGFloat x = centerX + curRadius * sin(angle);
            CGFloat y = centerY - curRadius * cos(angle);
            if (j == 0) {
                CGContextMoveToPoint(context, x, y);
            } else {
                CGContextAddLineToPoint(context, x, y);
            }
        }
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [PORTRAIT_POLYGON_FILL_COLOR_ARRAY[i - 1] CGColor]);
        CGContextSetStrokeColorWithColor(context, [PORTRAIT_POLYGON_STROKE_COLOR CGColor]);
        CGContextSetLineWidth(context, .5f);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    // 绘制从中心出发的 count 条白线
    for (NSInteger i = 0; i < count; i++) {
        CGFloat angle = unitAngle * i;
        CGContextMoveToPoint(context, centerX, centerY);
        CGFloat stopX = centerX + maxSideLength * sin(angle);
        CGFloat stopY = centerY - maxSideLength * cos(angle);
        CGContextAddLineToPoint(context, stopX, stopY);
        CGContextClosePath(context);
        CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextSetLineWidth(context, .5f);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // 绘制数据雷达图
    for (NSInteger i = 0; i < count; i++) {
        double value = [_dataArray objectAtIndex:i].value;
        CGFloat angle = unitAngle * i;
        CGFloat x = centerX + value * maxSideLength * sin(angle);
        CGFloat y = centerY - value * maxSideLength * cos(angle);
        if (i == 0) {
            CGContextMoveToPoint(context, x, y);
        } else {
            CGContextAddLineToPoint(context, x, y);
        }
    }
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [PORTRAIT_RADAR_FILL_COLOR CGColor]);
    CGContextSetStrokeColorWithColor(context, [PORTRAIT_RADAR_STROKE_COLOR CGColor]);
    CGContextSetLineWidth(context, .5f);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 绘制小圆环
    CGFloat outerRadius = 2.f;
    CGFloat innerRadius = 1.5f;
    for (NSInteger i = 0; i < count; i++) {
        double value = [_dataArray objectAtIndex:i].value;
        CGFloat angle = unitAngle * i;
        CGFloat cirX = centerX + value * maxSideLength * sin(angle);
        CGFloat cirY = centerY - value * maxSideLength * cos(angle);
        CGContextAddArc(context, cirX, cirY, outerRadius, 0, 2 * M_PI, 0);
        CGContextSetStrokeColorWithColor(context, [RADAR_RING_COLOR_ARRAYS[i % count] CGColor]);
        CGContextSetLineWidth(context, outerRadius - innerRadius);
        CGContextDrawPath(context, kCGPathStroke);
        
        CGContextAddArc(context, cirX, cirY, innerRadius, 0, 2 * M_PI, 0);
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextDrawPath(context, kCGPathFill);
    }
    
    // 绘制文本
    [self drawTextWithContext:context andCenterX:centerX andCenterY:centerY andMaxSideLength:maxSideLength andUnitAngle:unitAngle];
}

- (void)drawTextWithContext:(CGContextRef)context andCenterX:(CGFloat)centerX andCenterY:(CGFloat)centerY andMaxSideLength:(CGFloat)maxSideLength andUnitAngle:(CGFloat)unitAngle {
    NSInteger count = _dataArray.count;
    for (NSInteger i = 0; i < count; i++) {
        NSString *title = [_dataArray objectAtIndex:i].name;
        if (!title) {
            title = @"";
        }
        
        // 计算文字的宽高
        UIFont *textFount = [UIFont systemFontOfSize:14.f];
        UIColor *textColor = RADAR_RING_COLOR_ARRAYS[i % count];
        NSDictionary *textAttrs = [NSDictionary dictionaryWithObjectsAndKeys:textFount, NSFontAttributeName, textColor, NSForegroundColorAttributeName, nil];
        CGSize textSize = [title sizeWithAttributes:textAttrs];
        CGFloat angle = unitAngle * i;
        if (angle >= 2 * M_PI) {
            angle -= 2 * M_PI;
        }
        CGFloat x = centerX + (maxSideLength + textSize.height / 2) * sin(angle);
        CGFloat y = centerY - (maxSideLength + textSize.height / 2) * cos(angle);
        
        // 0 <= angle < 2 * M_PI
        if (angle <= .01f || angle >= 2 * M_PI - .01f) {
            // 0
            x -= textSize.width / 2;
            y -= textSize.height;
        } else if (angle < M_PI_2 - .01f) {
            // 第1象限
            y -= textSize.height;
        } else if (angle <= M_PI_2 + .01f) {
            // M_PI_2
            y -= textSize.height / 2;
        } else if (angle < M_PI- .01f) {
            // 第4象限
            // do nothing
        } else if (angle <= M_PI + .01f) {
            // M_PI
            x -= textSize.width / 2;
        } else if (angle < 3 * M_PI_2 - .01f) {
            // 第3象限
            x -= textSize.width;
        } else if (angle <= 3 * M_PI_2 + .01f) {
            // 3 * M_PI_2
            x -= textSize.width;
            y -= textSize.height / 2;
        } else if (angle < 2 * M_PI) {
            // 第2象限
            x -= textSize.width;
            y -= textSize.height;
        }
        
        CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
        CGContextAddRect(context, textRect);
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        CGContextDrawPath(context, kCGPathFill);
        [title drawInRect:textRect withAttributes:textAttrs];
    }
}

@end
