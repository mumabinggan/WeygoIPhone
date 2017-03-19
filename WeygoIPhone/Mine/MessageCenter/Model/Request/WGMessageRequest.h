//
//  WGMessageRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

typedef NS_ENUM(NSInteger, WGMessageTabType) {
    WGMessageTabTypeAll,
    WGMessageTabTypeNew,
    WGMessageTabTypeDeliver,
};

@interface WGMessageRequest : WGRequest

@property (nonatomic, assign) WGMessageTabType tabType;

@property (nonatomic, assign) NSInteger pageId;

@property (nonatomic, assign) NSInteger pageSize;

@end
