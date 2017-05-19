//
//  WGCheckBindResponse.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCheckBindResponse.h"

@implementation WGCheckBindResponse

- (BOOL)bind {
    return (self.code == 1);
}

- (BOOL)unBind {
    return (self.code == 2);
}

@end
