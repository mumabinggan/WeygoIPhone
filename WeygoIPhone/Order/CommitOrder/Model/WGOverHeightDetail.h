//
//  WGOverHeightDetail.h
//  WeygoIPhone
//
//  Created by muma on 2017/6/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGOverHeightDetail : WGObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *maxRise;

@property (nonatomic, strong) NSArray *goods;

//for self use
@property (nonatomic, assign, readonly) float currentRise;

@end
