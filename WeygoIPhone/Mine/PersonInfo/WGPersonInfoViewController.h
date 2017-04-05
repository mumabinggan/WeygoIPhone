//
//  WGPersonInfoViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"
#import "WGUser.h"

@interface WGPersonInfoViewController : WGViewController
{
    WGUser *_user;
    JHTableView *_tableView;
}

- (void)refreshUI;

@end
