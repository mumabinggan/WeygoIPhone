//
//  WGOrderStatusCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderStatusCell.h"
#import "WGOrderDetail.h"

@interface WGOrderStatusCell ()
{
    NSArray *_timeArray;
    NSArray *_statusArray;
}
@end

@implementation WGOrderStatusCell

- (void)showWithData:(JHObject *)data {
    WGOrderStatus *orderStatus = ((WGOrderDetail *)data).status;
    if (orderStatus) {
        if (_timeArray == nil) {
            NSMutableArray *timeMArray = [[NSMutableArray alloc] init];
            CGFloat height = kAppAdaptHeight(48);
            for (int num = 0; num < 3; ++num) {
                WGOrderStatusItem *item = orderStatus.statusArray[num];
                JHLabel *timeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), height * num, kAppAdaptWidth(95), height)];
                timeLabel.font = kAppAdaptFont(14);
                timeLabel.textColor = WGAppTitleColor;
                timeLabel.text = item.time;
                [self.contentView addSubview:timeLabel];
                [timeMArray addObject:timeLabel];
                
                JHLabel *statusLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(141), height * num, kDeviceWidth - kAppAdaptWidth(95), height)];
                statusLabel.font = kAppAdaptFont(14);
                statusLabel.text = item.statusText;
                statusLabel.textColor = WGAppNameLabelColor;
                [self.contentView addSubview:statusLabel];
                
                JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, num * height, kDeviceWidth, kAppSepratorLineHeight)];
                line.backgroundColor = WGAppSeparateLineColor;
                [self.contentView addSubview:line];
            }
            _timeArray = timeMArray;
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            UIBezierPath *linePath = [UIBezierPath bezierPath];
            [linePath moveToPoint:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(24))];
            [linePath addLineToPoint: CGPointMake(kAppAdaptWidth(121), kAppAdaptWidth(120))];
            layer.path = linePath.CGPath;
            layer.opacity = 1.0;
            layer.lineWidth = kAppAdaptWidth(8);
            layer.lineCap = kCALineCapRound;
            layer.strokeColor = kHRGB(0xEBEFF0).CGColor;
            [self.contentView.layer addSublayer:layer];
            
            if (orderStatus.currentStatus == 0) {
                CAShapeLayer *circleLayer = [CAShapeLayer layer];
                UIBezierPath *linePath = [UIBezierPath bezierPath];
                [linePath addArcWithCenter:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(24)) radius:kAppAdaptHeight(6) startAngle:0.0 endAngle:180.0 clockwise:YES];
                circleLayer.path = linePath.CGPath;
                circleLayer.lineWidth = kAppAdaptWidth(2);
                circleLayer.lineCap = kCALineCapRound;
                circleLayer.strokeColor = WGAppBlueButtonColor.CGColor;
                circleLayer.fillColor = kWhiteColor.CGColor;
                [self.contentView.layer addSublayer:circleLayer];
            }
            else if (orderStatus.currentStatus == 1) {
                CAShapeLayer *layer = [CAShapeLayer layer];
                UIBezierPath *linePath = [UIBezierPath bezierPath];
                [linePath moveToPoint:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(24))];
                [linePath addLineToPoint: CGPointMake(kAppAdaptWidth(121), kAppAdaptWidth(72))];
                layer.path = linePath.CGPath;
                layer.opacity = 1.0;
                layer.lineWidth = kAppAdaptWidth(8);
                layer.lineCap = kCALineCapRound;
                layer.strokeColor = WGAppBlueButtonColor.CGColor;
                [self.contentView.layer addSublayer:layer];
                
                CAShapeLayer *circleLayer = [CAShapeLayer layer];
                UIBezierPath *circleLinePath = [UIBezierPath bezierPath];
                [circleLinePath addArcWithCenter:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(24)) radius:kAppAdaptHeight(6) startAngle:0.0 endAngle:180.0 clockwise:YES];
                circleLayer.path = circleLinePath.CGPath;
                circleLayer.lineWidth = kAppAdaptWidth(2);
                circleLayer.lineCap = kCALineCapRound;
                circleLayer.strokeColor = WGAppBlueButtonColor.CGColor;
                circleLayer.fillColor = kWhiteColor.CGColor;
                [self.contentView.layer addSublayer:circleLayer];
                
                CAShapeLayer *circleLayer1 = [CAShapeLayer layer];
                UIBezierPath *circleLinePath1 = [UIBezierPath bezierPath];
                [circleLinePath1 addArcWithCenter:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(72)) radius:kAppAdaptHeight(6) startAngle:0.0 endAngle:180.0 clockwise:YES];
                circleLayer1.path = circleLinePath1.CGPath;
                circleLayer1.lineWidth = kAppAdaptWidth(2);
                circleLayer1.lineCap = kCALineCapRound;
                circleLayer1.strokeColor = WGAppBlueButtonColor.CGColor;
                circleLayer1.fillColor = kWhiteColor.CGColor;
                [self.contentView.layer addSublayer:circleLayer1];
            }
            else if (orderStatus.currentStatus == 2) {
                CAShapeLayer *layer = [CAShapeLayer layer];
                UIBezierPath *linePath = [UIBezierPath bezierPath];
                [linePath moveToPoint:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(24))];
                [linePath addLineToPoint: CGPointMake(kAppAdaptWidth(121), kAppAdaptWidth(120))];
                layer.path = linePath.CGPath;
                layer.opacity = 1.0;
                layer.lineWidth = kAppAdaptWidth(8);
                layer.lineCap = kCALineCapRound;
                layer.strokeColor = WGAppBlueButtonColor.CGColor;
                [self.contentView.layer addSublayer:layer];
                
                CAShapeLayer *circleLayer = [CAShapeLayer layer];
                UIBezierPath *circleLinePath = [UIBezierPath bezierPath];
                [circleLinePath addArcWithCenter:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(24)) radius:kAppAdaptHeight(6) startAngle:0.0 endAngle:180.0 clockwise:YES];
                circleLayer.path = circleLinePath.CGPath;
                circleLayer.lineWidth = kAppAdaptWidth(2);
                circleLayer.lineCap = kCALineCapRound;
                circleLayer.strokeColor = WGAppBlueButtonColor.CGColor;
                circleLayer.fillColor = kWhiteColor.CGColor;
                [self.contentView.layer addSublayer:circleLayer];
                
                CAShapeLayer *circleLayer1 = [CAShapeLayer layer];
                UIBezierPath *circleLinePath1 = [UIBezierPath bezierPath];
                [circleLinePath1 addArcWithCenter:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(72)) radius:kAppAdaptHeight(6) startAngle:0.0 endAngle:180.0 clockwise:YES];
                circleLayer1.path = circleLinePath1.CGPath;
                circleLayer1.lineWidth = kAppAdaptWidth(2);
                circleLayer1.lineCap = kCALineCapRound;
                circleLayer1.strokeColor = WGAppBlueButtonColor.CGColor;
                circleLayer1.fillColor = kWhiteColor.CGColor;
                [self.contentView.layer addSublayer:circleLayer1];
                
                CAShapeLayer *circleLayer2 = [CAShapeLayer layer];
                UIBezierPath *circleLinePath2 = [UIBezierPath bezierPath];
                [circleLinePath2 addArcWithCenter:CGPointMake(kAppAdaptWidth(121), kAppAdaptHeight(120)) radius:kAppAdaptHeight(6) startAngle:0.0 endAngle:180.0 clockwise:YES];
                circleLayer2.path = circleLinePath2.CGPath;
                circleLayer2.lineWidth = kAppAdaptWidth(2);
                circleLayer2.lineCap = kCALineCapRound;
                circleLayer2.strokeColor = WGAppBlueButtonColor.CGColor;
                circleLayer2.fillColor = kWhiteColor.CGColor;
                [self.contentView.layer addSublayer:circleLayer2];
            }
        }
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(144);
}

@end
