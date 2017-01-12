//
//  WGGoodBriefInfo.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/3.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGHomeFloorBaseContentItem.h"

typedef NS_ENUM(NSInteger, WGHomeFloorContentItemType) {
    WGHomeFloorContentItemTypeNone,             //no content
    
    WGHomeFloorContentItemTypeGood,         //good display
    
    WGHomeFloorContentItemTypeClassify,   //classify display
    
    WGHomeFloorContentItemTypeCountry,          //country display
};

@interface WGHomeFloorContentItem : WGObject

@property (nonatomic, assign) WGHomeFloorContentItemType type;

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *chineseName;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, strong) NSString *briefDescription;

@property (nonatomic, assign) float rating;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) float reducePrice;

@property (nonatomic, assign) float currentPrice;

@property (nonatomic, assign) float discount;

//for dif skip
@property (nonatomic, assign) int requestParameter;

//for self use
@property (nonatomic, strong) WGHomeFloorBaseContentItem *contentItem;

@end
