//
//  WGCommonViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommonViewController.h"

@interface WGCommonViewController (Request)

- (void)loadData;

- (void)loadContentWithMenuId:(NSInteger)menuId cacheType:(WGCacheType)cacheType;

@end
