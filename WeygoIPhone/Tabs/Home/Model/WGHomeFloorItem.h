//
//  WGHomeFloorItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

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

@interface WGHomeFloorItem : WGObject

@property (nonatomic, assign) WGHomeFloorItemType type;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *breifDescription;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, strong) NSString *pictureName;

@property (nonatomic, strong) NSArray *contents;

//for dif skip
@property (nonatomic, assign) int requestParameter;

//home page height
@property (nonatomic, assign) float height;

//home page name height
@property (nonatomic, assign) float homeNameHeight;

//home page picture height
@property (nonatomic, assign) float homePictureHeight;

//home page numberOfRowInSection
@property (nonatomic, assign) NSInteger homeRowCount;

//home page height of indexpath
- (CGFloat)heightOfContentItemOfRow:(NSInteger)row;

@end
