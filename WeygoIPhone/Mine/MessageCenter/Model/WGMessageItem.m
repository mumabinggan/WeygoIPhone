//
//  WGMessageItem.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGMessageItem.h"

@implementation WGMessageItem

- (NSString *)displayContent {
    NSString *string = nil;
    if (_displayAllContent) {
        string = _content;
    }
    else {
        if (_content.length > 60) {
            string = [NSString stringWithFormat:@"%@%@", [_content substringToIndex:60], kStr(@"MessageCenter More")];
        }
        else {
            string = _content;
        }
    }
    return string;
}

- (NSRange)moreRange {
    if (!_displayAllContent && _content.length > 60) {
        return NSMakeRange(60, kStr(@"MessageCenter More").length);
    }
    return NSMakeRange(0, 0);
}

@end
