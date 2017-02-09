//
//  WGApplication.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHObject.h"
#import "WGSessionResponse.h"
#import "WGBaseServiceResponse.h"
#import "WGUser.h"

@interface WGApplication : JHObject
{
    WGBaseServiceResponse *_baseServiceResponse;
    
    BOOL _loadingSessionResponse;
    WGSessionResponse *_sessionResponse;
    
    WGUser *_user;
}

+ (WGApplication *)sharedApplication;

@end
