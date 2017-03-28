//
//  WGApplication.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHObject.h"
#import "WGBaseServiceResponse.h"
#import "WGUser.h"
#import "MBProgressHUD.h"

@interface WGApplication : JHObject
{
    //Request
    
    
    //Operation
    WGUser *_user;
    WGBaseServiceInfo *_baseServiceInfo;
    
    //ShowView
    MBProgressHUD *HUD;
    JHView *_messageView;
}

+ (WGApplication *)sharedApplication;

@end
