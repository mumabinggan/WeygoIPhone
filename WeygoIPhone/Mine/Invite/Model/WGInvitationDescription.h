//
//  WGInvitationDescription.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@interface WGInvitationDescription : WGObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *imageURL;

@property (nonatomic, strong) NSString *imageText;

@property (nonatomic, strong) NSString *detailText;

@end
