//
//  WGOrderListPriceCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListPriceCell.h"

@interface WGOrderListPriceCell ()
{
    JHLabel *_label;
}
@end

@implementation WGOrderListPriceCell

- (void)loadSubviews {
    self.detailTextLabel.font = kAppAdaptFont(12);
    self.detailTextLabel.textColor = WGAppNameLabelColor;
    
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:lineView];
    
    _label = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(40), 0, kAppAdaptWidth(175), kAppAdaptHeight(48))];
    _label.font = kAppAdaptFont(12);
    _label.textColor = WGAppTitleColor;
    [self.contentView addSubview:_label];
}

- (void)showWithData:(JHObject *)data {
    WGOrderListItem *item = (WGOrderListItem *)data;
    if (item) {
        self.imageView.image = [UIImage imageNamed:@"deliver_car"];
//        CGSize itemSize = CGSizeMake(kAppAdaptWidth(20), kAppAdaptHeight(14));
//        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
//        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//        [self.imageView.image drawInRect:imageRect];
//        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        
        NSString *totalPrice = [NSString stringWithFormat:kStr(@"Totale:Price With Unit"), item.totalPrice];
        NSString *devilerPrice = item.deliverPrice;
        _label.text = [NSString stringWithFormat:@"%@   %@", devilerPrice, totalPrice];
        [_label setPartString:totalPrice attributes:@{NSForegroundColorAttributeName : WGAppBaseColor}];
        self.detailTextLabel.text = [NSString stringWithFormat:kStr(@"Order List How Many Good"), item.goods.count];
    }
}

@end
