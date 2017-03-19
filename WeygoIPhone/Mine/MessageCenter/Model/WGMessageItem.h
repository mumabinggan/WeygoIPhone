//
//  WGMessageItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGMessageItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) BOOL isRead;

//for self use;
@property (nonatomic, strong) NSString *displayContent;

@property (nonatomic, assign) BOOL displayAllContent;

@property (nonatomic, assign) NSRange moreRange;

@end
