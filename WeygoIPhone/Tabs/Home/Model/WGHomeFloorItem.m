//
//  WGHomeFloorItem.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorItem.h"
#import "WGHomeFloorContentItem.h"

@implementation WGHomeFloorItem

+ (Class)classForArray:(NSString *)propertyName {
    if ([@"contents" isEqualToString:propertyName]) {
        return [WGHomeFloorContentItem class];
    }
    return nil;
}

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

- (float)height {
    if (_height >= 0.001) {
        return _height;
    }
    float height = 0.0;
    //title cell
    height += self.homeNameHeight;
    
    //picture cell
    height += self.homePictureHeight;
    
    //content cell
    if (_type == WGHomeFloorItemTypeCountry) {
        height += 120;
    }
    else if (_type == WGHomeFloorItemTypeGoodList) {
        height += (kAppAdaptHeight(124) * _contents.count + kAppAdaptHeight(56));
    }
    else if (_type == WGHomeFloorItemTypeGoodColumn) {
        height += kAppAdaptHeight(232);
    }
    else if (_type == WGHomeFloorItemTypeGoodGrid) {
        height += kAppAdaptHeight(232) * ((_contents.count + 1) / 2);
    }
    else if (_type == WGHomeFloorItemTypeClassifyList) {
        height += kAppAdaptHeight(184) * (_contents.count);
    }
    else if (_type == WGHomeFloorItemTypeClassifyColumn) {
        height += kAppAdaptHeight(130);
    }
    else if (_type == WGHomeFloorItemTypeClassifyGrid) {
        height += kAppAdaptHeight(136) * ((_contents.count + 3) / 4);
    }
    
    return height;
}

- (NSInteger)homeRowCount {
    if (_homeRowCount != 0 && _homeRowCount != 2) {
        return _homeRowCount;
    }

    _homeRowCount = 2;
    /*
    _homeRowCount += [NSString isNullOrEmpty:_name] ? 0 : 1;
    _homeRowCount += [NSString isNullOrEmpty:_pictureURL] ? 0 : 1;
    */
    if (_type == WGHomeFloorItemTypeCountry) {
        _homeRowCount += (_contents.count + 3) / 4;
    }
    else if (_type == WGHomeFloorItemTypeGoodList) {
        _homeRowCount += (_contents.count + 1);
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

- (CGFloat)heightOfContentItemOfRow:(NSInteger)row {
    CGFloat height = 0.0f;
    if (row == 0) {
        height = self.homeNameHeight;
    }
    else if (row == 1) {
        height = self.homePictureHeight;
    }
    else {
        NSInteger begin = row - 2;
        if (_type == WGHomeFloorItemTypeCountry) {
            height = kAppAdaptHeight(120);
        }
        else if (_type == WGHomeFloorItemTypeGoodList) {
            height = (_contents.count > begin) ? kAppAdaptHeight(124) : kAppAdaptHeight(56);
        }
        else if (_type == WGHomeFloorItemTypeGoodColumn) {
            height = kAppAdaptHeight(232);
        }
        else if (_type == WGHomeFloorItemTypeGoodGrid) {
            height = kAppAdaptHeight(232);
        }
        else if (_type == WGHomeFloorItemTypeClassifyList) {
            height = kAppAdaptHeight(184);
        }
        else if (_type == WGHomeFloorItemTypeClassifyColumn) {
            height = kAppAdaptHeight(130);
        }
        else if (_type == WGHomeFloorItemTypeClassifyGrid) {
            height = kAppAdaptHeight(136);;
        }
    }
    return height;
}

@end
