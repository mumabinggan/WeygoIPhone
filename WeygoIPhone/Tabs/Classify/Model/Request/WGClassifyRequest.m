//
//  WGClassifyRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyRequest.h"

@implementation WGClassifyRequest

- (NSString *)pathName {
    return @"mobile_category.categoryPage";
}

- (NSArray *)parameterValueArray {
    return @[@"f1db8542447477960c3336b0fe4bb78f", self.pathName];
}

@end
