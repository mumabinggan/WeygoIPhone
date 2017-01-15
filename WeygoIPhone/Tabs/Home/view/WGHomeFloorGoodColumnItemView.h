//
//  WGHomeFloorGoodColumnItemView.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGHomeFloorContentGoodItem.h"

@interface WGHomeFloorGoodColumnItemView : JHView
{
    JHLabel         *_nameLabel;
    JHLabel         *_currentPriceLabel;
    JHLabel         *_reducePriceLabel;
    
    JHButton        *_purchaseBtn;
}

- (void)showWithData:(WGHomeFloorContentGoodItem *)object;

@end
