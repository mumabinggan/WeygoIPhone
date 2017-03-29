//
//  WGBaseFootPrintAndCollectionViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@interface WGBaseFootPrintAndCollectionViewController : WGViewController
{
    NSMutableArray *_dataMArray;
    TWRefreshTableView *_tableView;
}

- (void)refreshUI;

@end
