//
//  WGHomeTabLayout.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTabLayout.h"
#import "WGHomeFloorItem.h"

@interface WGHomeTabLayout ()
{
    WGHome *_data;
}
@end

@implementation WGHomeTabLayout

- (instancetype)initWithData:(WGHome *)data {
    if ([super init]) {
        _data = data;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize {
    if (!_data) {
        return CGSizeMake(0, 0);
    }
    
    float height = 0.0f;
    if (_data.carouselFigures && _data.carouselFigures.count > 0) {
        height += _data.homeCarouselFiguresHeight;
    }
    
    if (_data.topics && _data.topics.count > 0) {
        height += _data.homeTopicsHeight;
    }
    
    if (_data.news && _data.news.count > 0) {
        height += _data.homeNewsHeight;
    }
    
    for (WGHomeFloorItem *floor in _data.floors) {
        height += (floor.height + kAppAdaptHeight(8));
    }
    
    return CGSizeMake(self.collectionView.width, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 0) {
        float y = 0.0f;
        if (indexPath.row == 0) {
            float height = _data ? _data.homeCarouselFiguresHeight : 0;
            attribute.frame = CGRectMake(0, y, kDeviceWidth, height);
            y = height;
        }
        else if (indexPath.row == 1) {
            float height = _data ? _data.homeTopicsHeight : 0;
            attribute.frame = CGRectMake(0, y, kDeviceWidth, height);
            y += height;
        }
        else if (indexPath.row == 2) {
            float height = _data ? _data.homeNewsHeight : 0;
            attribute.frame = CGRectMake(0, y, kDeviceWidth, height);
        }
    }
    else {
        if (_data.floors.count > indexPath.section - 1) {
            WGHomeFloorItem *item = _data.floors[indexPath.section - 1];
            float y = 0.0f;
            if (indexPath.row == 0) {
                float height = item.homeNameHeight;
                attribute.frame = CGRectMake(0, y, kDeviceWidth, height);
                y += height;
            }
            else if (indexPath.row == 1) {
                float height = item.homePictureHeight;
                attribute.frame = CGRectMake(0, y, kDeviceWidth, height);
                y += height;
            }
            else {
                
            }
        }
    }
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int num = 0; num < sectionCount; ++num) {
        NSInteger items = [self.collectionView numberOfItemsInSection:num];
        for (int i = 0; i<items;i++) {
            UICollectionViewLayoutAttributes* attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:num]];
            [array addObject:attr];
        }
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
//    CGRect oldBounds = self.collectionView.bounds;
//    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
//        return YES;
//    }
//    return NO;;
}

@end
