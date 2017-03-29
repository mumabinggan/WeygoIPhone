//
//  WGClassifyItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGClassifyItem : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, strong) NSArray *subArray;

@property (nonatomic, strong) NSArray *goodArray;

//use for filter classify
@property (nonatomic, assign) BOOL isSelected;

//use for self
@property (nonatomic, strong) NSArray *allArray;

@end
