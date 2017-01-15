//
//  WGHomeFloorItem.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"
#import "WGHomeFloorContentItem.h"

@interface WGHomeFloorItem : WGObject

@property (nonatomic, assign) WGHomeFloorItemType type;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *breifDescription;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, strong) NSString *pictureName;

@property (nonatomic, strong) NSArray *contents;

//for dif skip
@property (nonatomic, assign) int requestParameter;



//home page name height
@property (nonatomic, assign) float homeNameHeight;

//home page picture height
@property (nonatomic, assign) float homePictureHeight;

//home page numberOfRowInSection
@property (nonatomic, assign) NSInteger homeRowCount;

//text head only name
@property (nonatomic, assign, readonly) BOOL onlyName;

//home page height of indexpath
- (CGFloat)heightOfContentItemOfRow:(NSInteger)row;

//texthead

@end
