//
//  WGGoodBriefInfo.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/3.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorContentItem.h"
#import "WGHomeFloorContentCountryItem.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGHomeFloorContentClassifyItem.h"
#import "WGHomeFloorContentItem.h"

@implementation WGHomeFloorContentItem

- (WGHomeFloorBaseContentItem *)contentItem {
    if (!_contentItem) {
        if (_type == WGHomeFloorItemTypeCountry) {
            WGHomeFloorContentCountryItem *countryItem = [[WGHomeFloorContentCountryItem alloc] init];
            _contentItem = countryItem;
        }
        else if (_type == WGHomeFloorItemTypeGoodList ||
                 _type == WGHomeFloorItemTypeGoodColumn ||
                 _type == WGHomeFloorItemTypeGoodGrid) {
            WGHomeFloorContentGoodItem *goodItem = [[WGHomeFloorContentGoodItem alloc] init];
            goodItem.chineseName = _chineseName;
            goodItem.briefDescription = _briefDescription;
            goodItem.rating = _rating;
            goodItem.price = _price;
            goodItem.reducePrice = _reducePrice;
            goodItem.currentPrice = _currentPrice;
            goodItem.discount = _discount;
            _contentItem = goodItem;
        }
        else if (_type == WGHomeFloorItemTypeClassifyList ||
                 _type == WGHomeFloorItemTypeClassifyColumn ||
                 _type == WGHomeFloorItemTypeClassifyGrid) {
            WGHomeFloorContentClassifyItem *classifyItem = [[WGHomeFloorContentClassifyItem alloc] init];
            _contentItem = classifyItem;
        }
        _contentItem.id = _id;
        _contentItem.name = _name;
        _contentItem.pictureURL = _pictureURL;
        _contentItem.requestParameter = _requestParameter;
    }
    return _contentItem;
}

- (void)calculateContentHeight {
    float height = 0.0f;
    if (_type == WGHomeFloorItemTypeCountry) {
        height = kAppAdaptHeight(120);
    }
    else if (_type == WGHomeFloorItemTypeGoodList) {
        height = kAppAdaptHeight(124);
    }
    else if (_type == WGHomeFloorItemTypeGoodColumn) {
        height = kAppAdaptHeight(232);
    }
    else if (_type == WGHomeFloorItemTypeGoodGrid) {
        height = kAppAdaptHeight(320);
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
    _contentHeight = height;
}

@end
