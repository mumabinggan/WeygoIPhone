//
//  WGIntitationDescriptionResponse.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGResponse.h"
#import "WGInvitationDescription.h"

@interface WGInvitationDescriptionResponse : WGResponse

@property (nonatomic, strong) WGInvitationDescription *data;

@end
