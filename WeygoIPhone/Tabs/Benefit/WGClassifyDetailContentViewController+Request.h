//
//  WGCommonClassifyDetailViewController+Request.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailContentViewController.h"

@interface WGClassifyDetailContentViewController (Request)

- (void)loadNeedCheckData:(WGCacheType)cacheType;

- (void)loadData:(BOOL)refresh pulling:(BOOL)pulling cacheType:(WGCacheType)cacheType;

@end
