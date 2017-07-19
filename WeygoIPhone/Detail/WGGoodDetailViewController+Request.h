//
//  WGGoodDetailViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodDetailViewController.h"
#import "WGGoodDetailRequest.h"
#import "WGGoodDetailResponse.h"

@interface WGGoodDetailViewController (Request)

- (void)loadGoodDetail;

- (void)loadGoodDetailRecommend;

- (void)requestCollectGood:(BOOL)collect;

@end
