//
//  WGDealShopCartGiftGoodView.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHPopoverView.h"

@interface WGDealShopCartGiftGoodView : JHPopoverView

@property (nonatomic, strong) void (^onApply)(int index);

@property (nonatomic, strong) NSArray *goods;

@end
