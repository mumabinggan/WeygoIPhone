//
//  WGHomeTabBseContentViewController.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@interface WGHomeTabBaseContentViewController : WGViewController
{
    TWRefreshCollectionView *_collectionView;
    TWRefreshTableView *_tableView;
}

- (void)loadData:(JHObject *)object;

@end
