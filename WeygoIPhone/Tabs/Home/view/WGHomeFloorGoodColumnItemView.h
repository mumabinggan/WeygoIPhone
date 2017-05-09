//
//  WGHomeFloorGoodColumnItemView.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGHomeFloorContentGoodItem.h"
#import "WGDiscountView.h"

@interface WGHomeFloorGoodColumnItemView : JHView
{
    JHImageView     *_imageView;
    WGDiscountView *_discountView;
    
    JHLabel         *_nameLabel;
    JHLabel         *_currentPriceLabel;
    JHLabel         *_reducePriceLabel;
    
    JHButton        *_purchaseBtn;
    JHButton        *_notPurchaseBtn;
}

- (void)showWithData:(WGHomeFloorContentGoodItem *)object;

@end
