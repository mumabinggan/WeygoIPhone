//
//  WGCommitOrderUpdateTimeRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/7/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGCommitOrderUpdateTimeRequest : WGGuestRequest

@property (nonatomic, strong) NSString *timeId;

@end