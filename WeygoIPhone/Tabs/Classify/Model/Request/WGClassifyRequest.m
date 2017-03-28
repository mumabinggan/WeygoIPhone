//
//  WGClassifyRequest.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyRequest.h"

@implementation WGClassifyRequest

- (NSString *)api {
    return @"catalogSearch/getCategories?";
}

- (NSString *)url {
    return @"http://delong6688.develop.weygo.com/appservice/catalogSearch/getCategories?sign=77091032144e63276d0448ad0c3cb8dd";
}

@end
