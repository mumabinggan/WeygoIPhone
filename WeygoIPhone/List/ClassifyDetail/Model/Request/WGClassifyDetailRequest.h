//
//  WGClassifyDetailRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

@interface WGClassifyDetailRequest : WGRequest

@property (nonatomic, assign) long long classifyId;

@property (nonatomic, strong) NSString *brandIds;

@property (nonatomic, strong) NSString *subClassifyIds;

@property (nonatomic, assign) int pageId;

@property (nonatomic, assign) int pageSize;

@property (nonatomic, assign) int order;    //0:默认, 1:品牌 2：价格从低到高 3:价格从高到低

@end
