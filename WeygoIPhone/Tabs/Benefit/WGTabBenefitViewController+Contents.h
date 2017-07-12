//
//  WGTabBenefitViewController+Contents.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController.h"

@interface WGTabBenefitViewController (Contents)

//- (void)initTabContentDictionary;

- (void)addContentsWithIndex:(NSInteger)index;

- (void)refreshContent:(NSInteger)index cacheType:(WGCacheType)cacheType;

@end
