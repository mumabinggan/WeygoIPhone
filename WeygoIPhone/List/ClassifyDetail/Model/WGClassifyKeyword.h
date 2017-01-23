//
//  WGKeyword.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGClassifyKeyword : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *name;

//self use
@property (nonatomic, assign) BOOL isSelected;

@end
