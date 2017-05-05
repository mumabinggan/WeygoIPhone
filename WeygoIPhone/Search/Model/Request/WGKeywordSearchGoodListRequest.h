//
//  WGKeywordSearchGoodListRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGKeywordSearchGoodListRequest : WGRequest

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) int pageId;

@property (nonatomic, assign) int pageSize;

@property (nonatomic, assign) int orderId;//0:默认, 1:品牌 2：价格从低到高 3:价格从高到低

@end
