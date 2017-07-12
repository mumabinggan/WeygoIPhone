//
//  WGBenefitTabResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@interface WGBenefitTabResponse : WGResponse

@property (nonatomic, strong) NSArray *data;

- (void)setTitles:(WGBenefitTabResponse *)response;

@end
