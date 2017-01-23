//
//  WGClassifyFitlerClassifyView.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/23.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHView.h"

@interface WGClassifyFitlerClassifyView : JHView

@property (nonatomic, assign, readonly) BOOL selected;

- (void)showWithData:(JHObject *)object;

@end
