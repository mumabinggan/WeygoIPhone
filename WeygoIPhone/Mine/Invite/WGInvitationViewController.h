//
//  WGInvitationViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGInvitationDescription.h"

@interface WGInvitationViewController : WGViewController
{
    WGInvitationDescription *_data;
    JHTextField *_emailTextField;
}

- (void)refreshUI;

@end
