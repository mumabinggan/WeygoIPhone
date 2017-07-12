//
//  WGHomeTabTitleResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"

@interface WGHomeTabTitleResponse : WGResponse

@property (nonatomic, strong) NSArray *data;

- (BOOL)titlesEqual:(WGHomeTabTitleResponse *)response;

- (void)setTitles:(WGHomeTabTitleResponse *)response;

@end
