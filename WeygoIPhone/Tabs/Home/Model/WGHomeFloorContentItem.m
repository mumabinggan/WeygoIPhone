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

@interface WGHomeFloorContentItem ()
{
    WGHomeFloorBaseContentItem *_contentItem;
}

@end

@implementation WGHomeFloorContentItem

- (WGHomeFloorBaseContentItem *)contentItemWithType:(WGHomeFloorItemType)type {
    if (!_contentItem) {
        if (type == WGHomeFloorItemTypeCountry) {
            WGHomeFloorContentCountryItem *countryItem = [[WGHomeFloorContentCountryItem alloc] init];
            _contentItem = countryItem;
        }
        else if (type == WGHomeFloorItemTypeGoodList ||
                 type == WGHomeFloorItemTypeGoodColumn ||
                 type == WGHomeFloorItemTypeGoodGrid) {
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
        else if (type == WGHomeFloorItemTypeClassifyList ||
                 type == WGHomeFloorItemTypeClassifyColumn ||
                 type == WGHomeFloorItemTypeClassifyGrid) {
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

- (CGFloat)heightWithType:(WGHomeFloorItemType)type {
    float height = 0.0f;
    if (type == WGHomeFloorItemTypeCountry) {
        height = kAppAdaptHeight(120);
    }
    else if (type == WGHomeFloorItemTypeGoodList) {
        height = kAppAdaptHeight(124);
    }
    else if (type == WGHomeFloorItemTypeGoodColumn) {
        height = kAppAdaptHeight(232);
    }
    else if (type == WGHomeFloorItemTypeGoodGrid) {
        height = kAppAdaptHeight(320);
    }
    else if (type == WGHomeFloorItemTypeClassifyList) {
        height = kAppAdaptHeight(184);
    }
    else if (type == WGHomeFloorItemTypeClassifyColumn) {
        height = kAppAdaptHeight(130);
    }
    else if (type == WGHomeFloorItemTypeClassifyGrid) {
        height = kAppAdaptHeight(136);;
    }
    return height;
}

@end
