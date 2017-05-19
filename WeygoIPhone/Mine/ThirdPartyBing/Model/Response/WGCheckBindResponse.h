//
//  WGCheckBindResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@interface WGCheckBindResponse : WGResponse

- (BOOL)bind;

- (BOOL)unBind;

@property (nonatomic, strong) WGUser *data;

@end
