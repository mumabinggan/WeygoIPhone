//
//  WGOrderListPriceCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListPriceCell.h"

@implementation WGOrderListPriceCell

- (void)loadSubviews {
    self.textLabel.font = kAppAdaptFont(12);
    self.textLabel.textColor = WGAppTitleColor;
    self.detailTextLabel.font = self.textLabel.font;
    self.detailTextLabel.textColor = WGAppNameLabelColor;
    
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:lineView];
}

- (void)showWithData:(JHObject *)data {
    WGOrderListItem *item = (WGOrderListItem *)data;
    if (item) {
        self.imageView.image = [UIImage imageNamed:@""];
        CGSize itemSize = CGSizeMake(kAppAdaptWidth(20), kAppAdaptHeight(14));
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [self.imageView.image drawInRect:imageRect];
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSString *totalPrice = [NSString stringWithFormat:kStr(@"Totale:Price With Unit"), item.totalPrice];
        NSString *devilerPrice = [NSString stringWithFormat:kStr(@"Price With 2 Unit"), item.deliverPrice];
        self.textLabel.text = [NSString stringWithFormat:@"%@   %@", devilerPrice, totalPrice];
        [self.textLabel setPartString:totalPrice attributes:@{NSForegroundColorAttributeName : WGAppBaseColor}];
        self.detailTextLabel.text = [NSString stringWithFormat:kStr(@"Order List How Many Good"), item.goods.count];
    }
}

@end
