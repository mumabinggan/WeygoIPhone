//
//  WGCommitOrderViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderViewController.h"

@interface WGCommitOrderViewController (Request)

- (void)loadSettlementResultDetail;

- (void)loadCommitOrder;

- (void)loadOverHeightDetail;

- (void)loadDeleteOverHeight;

- (void)loadOverHeightReset:(NSArray *)array;

- (void)loadDeleteExpireGoodRequest;

- (void)loadUpdateTimeRequest;

@end
