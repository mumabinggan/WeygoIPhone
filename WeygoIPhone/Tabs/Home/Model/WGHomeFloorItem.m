//
//  WGHomeFloorItem.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorItem.h"

@implementation WGHomeFloorItem

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"contents" isEqualToString:propertyName]) {
        return [WGHomeFloorContentItem class];
    }
    return [super classForArray:propertyName];
}

//+ (NSDictionary *)convertKeyMapper {
//    return @{@"contents" : @"content"};
//}

- (float)homeNameHeight {
    if (_homeNameHeight >= 0.001) {
        return _homeNameHeight;
    }
    _homeNameHeight = [NSString isNullOrEmpty:_name] ? 0 : ([NSString isNullOrEmpty:_breifDescription] ? kAppAdaptHeight(40) : kAppAdaptHeight(64));
    return _homeNameHeight;
}

- (float)homePictureHeight {
    return [NSString isNullOrEmpty:_pictureURL] ? 0 : kAppAdaptHeight(136);
}

- (NSInteger)homeRowCount {
    if (_homeRowCount != 0 && _homeRowCount != 2) {
        return _homeRowCount;
    }

    _homeRowCount = 2;

    if (_type == WGHomeFloorItemTypeCountry) {
        _homeRowCount += (_contents.count + 3) / 4;
    }
    else if (_type == WGHomeFloorItemTypeGoodList) {
        _homeRowCount += (_contents.count > 4) ? 5 : _contents.count;
    }
    else if (_type == WGHomeFloorItemTypeGoodColumn) {
        _homeRowCount += 1;
    }
    else if (_type == WGHomeFloorItemTypeGoodGrid) {
        _homeRowCount += ((_contents.count + 1) / 2);
    }
    else if (_type == WGHomeFloorItemTypeClassifyList) {
        _homeRowCount += (_contents.count);
    }
    else if (_type == WGHomeFloorItemTypeClassifyColumn) {
        _homeRowCount += 1;
    }
    else if (_type == WGHomeFloorItemTypeClassifyGrid) {
        _homeRowCount += ((_contents.count + 3) / 4);
    }
    
    return _homeRowCount;
}

- (BOOL)onlyName {
    return [NSString isNullOrEmpty:_breifDescription];
}

- (CGFloat)heightOfContentItemOfRow:(NSInteger)row {
    CGFloat height = 0.0f;
    if (row == 0) {
        height = self.homeNameHeight;
    }
    else if (row == 1) {
        height = self.homePictureHeight;
    }
    else {
        NSInteger index = row - 2;
        if (_type == WGHomeFloorItemTypeGoodList) {
            JHObject *item = _contents[index];
            height = (_contents.count > index) ? item.contentHeight : kAppAdaptHeight(56);
        }
        else {
            JHObject *item = _contents[0];
            if (_type == WGHomeFloorItemTypeCountry) {
                height = item.contentHeight;
            }
            else if (_type == WGHomeFloorItemTypeGoodColumn) {
                height = item.contentHeight;
            }
            else if (_type == WGHomeFloorItemTypeGoodGrid) {
                height = item.contentHeight + (((_contents.count + 1) / 2 == index + 1) ? kAppAdaptHeight(8) : 0);
            }
            else if (_type == WGHomeFloorItemTypeClassifyList) {
                height = item.contentHeight + ((_contents.count == index + 1) ? kAppAdaptHeight(8) : 0);
            }
            else if (_type == WGHomeFloorItemTypeClassifyColumn) {
                height = item.contentHeight;
            }
            else if (_type == WGHomeFloorItemTypeClassifyGrid) {
                height = item.contentHeight;
            }
        }
    }
    return height;
}

@end
