//
//  WGOrderListGoodsCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListGoodsCell.h"
#import "WGHomeFloorGoodColumnItemView.h"
#import "WGOrderCountView.h"
#import "WGOrderGoodItem.h"
#import "WGOrderListItem.h"

@interface WGOrderListGoodItemView : JHCollectionViewCell
{
    WGHomeFloorGoodColumnItemView *_itemView;
    WGOrderCountView *_countView;
}
@end

@implementation WGOrderListGoodItemView

- (void)loadSubviews {
    _itemView = [[WGHomeFloorGoodColumnItemView alloc] initWithFrame:self.bounds radius:kAppAdaptHeight(6)];
    _itemView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:_itemView];
    
    _countView = [[WGOrderCountView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptHeight(8), kAppAdaptWidth(24), kAppAdaptWidth(24))];
    [_itemView addSubview:_countView];
}

- (void)showWithData:(JHObject *)data {
    WGOrderGoodItem *item = (WGOrderGoodItem *)data;
    if (item) {
        [_itemView showWithData:item];
        _itemView.discountView.hidden = YES;
        _countView.value = [NSString stringWithFormat:kStr(@"Order Good Number"), item.goodCount];
    }
}

@end

@interface WGOrderListGoodsCell ()
{
    JHCollectionView *_collectionView;
    NSArray *_dataArray;
}
@end

@interface WGOrderListGoodsCell (CollectionDelegate) <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation WGOrderListGoodsCell

- (void)loadSubviews {
    [super loadSubviews];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = kAppAdaptWidth(10);
    _collectionView = [[JHCollectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(232)) collectionViewLayout:layout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = kHRGB(0xF8FAFA);
    _collectionView.scrollsToTop = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, kAppAdaptWidth(15), 0, 0);
    [_collectionView registerClass:[WGOrderListGoodItemView class] forCellWithReuseIdentifier:@"OrderGoodItemView"];
    [self.contentView addSubview:_collectionView];
    
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:lineView];
}

- (void)showWithData:(JHObject *)object {
    WGOrderListItem *item = (WGOrderListItem *)object;
    if (item) {
        _dataArray = item.goods;
        [_collectionView reloadData];
    }
}

- (void)showWithArray:(NSArray *)array {
    if (array) {
        _dataArray = array;
        [_collectionView reloadData];
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    WGOrderListItem *item = (WGOrderListItem *)data;
    return [self heightWithArray:item.goods];
}

+ (CGFloat)heightWithArray:(NSArray *)data {
    if (data.count == 0) {
        return 0;
    }
    else {
        return kAppAdaptHeight(232);
    }
}

@end

@implementation WGOrderListGoodsCell (CollectionDelegate)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderGoodItemView" forIndexPath:indexPath];
    [cell showWithData:_dataArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kAppAdaptWidth(128), kAppAdaptHeight(216));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataArray.count > indexPath.row) {
        if (self.onApply) {
            WGOrderGoodItem *item = _dataArray[indexPath.row];
            self.onApply(item);
        }
    }
}

@end
