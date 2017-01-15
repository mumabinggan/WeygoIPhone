//
//  WGGoodBriefInfo.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/3.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGHomeFloorBaseContentItem.h"

typedef NS_ENUM(NSInteger, WGHomeFloorItemType) {
    WGHomeFloorItemTypeNone,             //no content
    
    WGHomeFloorItemTypeGoodList,         //good list display
    WGHomeFloorItemTypeGoodColumn,       //good column display
    WGHomeFloorItemTypeGoodGrid,         //good grid display
    
    WGHomeFloorItemTypeClassifyList,   //classify list display
    WGHomeFloorItemTypeClassifyColumn,   //classify column display
    WGHomeFloorItemTypeClassifyGrid,     //classify grid display
    
    WGHomeFloorItemTypeCountry,          //country display
};

@interface WGHomeFloorContentItem : WGObject

@property (nonatomic, assign) WGHomeFloorItemType type;

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
