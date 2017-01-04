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

@implementation WGHomeFloorContentItem

- (WGHomeFloorBaseContentItem *)contentItem {
    if (!_contentItem) {
        if (_type == WGHomeFloorContentItemTypeCountry) {
            WGHomeFloorContentCountryItem *countryItem = [[WGHomeFloorContentCountryItem alloc] init];
            _contentItem = countryItem;
        }
        else if (_type == WGHomeFloorContentItemTypeGoodGrid ||
                 _type == WGHomeFloorContentItemTypeGoodColumn ||
                 _type == WGHomeFloorContentItemTypeGoodList) {
            WGHomeFloorContentGoodItem *goodItem = [[WGHomeFloorContentGoodItem alloc] init];
            goodItem.briefDescription = _briefDescription;
            goodItem.rating = _rating;
            goodItem.price = _price;
            goodItem.reducePrice = _reducePrice;
            goodItem.currentPrice = _currentPrice;
            goodItem.discount = _discount;
            _contentItem = goodItem;
        }
        else if (_type == WGHomeFloorContentItemTypeClassifyGrid ||
                 _type == WGHomeFloorContentItemTypeClassifyColumn) {
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

@end
