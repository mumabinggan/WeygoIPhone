//
//  WGOverweightView.m
//  WeygoIPhone
//
//  Created by muma on 2017/6/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOverweightView.h"
#import "WGOverHeightGoodItem.h"
#import "WGOverHeightGoodCell.h"

@interface WGOverweightView () <UITableViewDelegate, UITableViewDataSource>
{
    UIView *_contentView;
    JHLabel *_titleLabel;
    JHLabel *_maxRaseLabel;
    JHLabel *_currentRaseLabel;
    JHTableView *_scrollView;
    JHButton *_noBtn;
    JHButton *_noUnableBtn;
    NSArray *_detailArray;
}
@end

@implementation WGOverweightView

- (id)initWithFrame:(CGRect)frame overHeightDetail:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        _detailArray = array;
        [self refreshUI];
    }
    return self;
}

- (void)refreshUI {
    WGOverHeightDetail *detail = _detailArray[0];
    _titleLabel.text = detail.title;
    _maxRaseLabel.text = [NSString stringWithFormat:kStr(@"CommitOrder_OverHeight_MaxRise"), detail.maxRise, kStr(@"CommitOrder_OverHeight_Rise")];
    [_maxRaseLabel setPartString:[NSString stringWithFormat:@"%@%@", detail.maxRise, kStr(@"CommitOrder_OverHeight_Rise")] attributes:@{NSForegroundColorAttributeName : kHRGB(0XD80027), NSFontAttributeName : kAppAdaptFont(18)}];
    [self setCurrentRiseLabel];
    [self setNoButton];
}

- (void)loadSubviews {
    [super loadSubviews];
    self.maskColor = kHRGBA(0x000000, 0.4);
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    _contentView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(300), kAppAdaptHeight(450)) radius:kAppAdaptWidth(24)];
    _contentView.backgroundColor = kHRGBA(0xF8FAFA, 0.88);
    _contentView.backgroundColor = kWhiteColor;
    _contentView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
    [self addSubview:_contentView];
    
    _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, _contentView.width, kAppAdaptHeight(72))];
    _titleLabel.font = kAppAdaptFontBold(14);
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = WGAppNameLabelColor;
    
    [_contentView addSubview:_titleLabel];
    
    _maxRaseLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _titleLabel.maxY, _contentView.width, kAppAdaptHeight(24))];
    _maxRaseLabel.font = kAppAdaptFontBold(14);
    _maxRaseLabel.textAlignment = NSTextAlignmentCenter;
    _maxRaseLabel.textColor = kBlackColor;
    
    [_contentView addSubview:_maxRaseLabel];
    
    _currentRaseLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _maxRaseLabel.maxY + kAppAdaptHeight(6), _contentView.width, kAppAdaptHeight(32))];
    _currentRaseLabel.font = kAppAdaptFontBold(14);
    _currentRaseLabel.textAlignment = NSTextAlignmentCenter;
    _currentRaseLabel.textColor = kWhiteColor;
    [_contentView addSubview:_currentRaseLabel];
    
    _scrollView = [[JHTableView alloc] initWithFrame:CGRectMake(0, _currentRaseLabel.maxY, _contentView.width, kAppAdaptHeight(200))];
    _scrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _scrollView.delegate = self;
    _scrollView.dataSource = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = _contentView.backgroundColor;
    _scrollView.bounces = NO;
    [_contentView addSubview:_scrollView];
    
    JHButton *okBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(70), _scrollView.maxY + kAppAdaptHeight(20), kAppAdaptWidth(160), kAppAdaptHeight(30)) difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:WGAppBaseColor];
    [okBtn setTitle:kStr(@"CommitOrder_OverHeight_DeleteBtnTitle") forState:UIControlStateNormal];
    okBtn.titleLabel.font = kAppAdaptFont(12);
    [okBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(touchOkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:okBtn];
    
    CGRect frame = okBtn.frame;
    frame.origin.y = okBtn.maxY + kAppAdaptHeight(16);
    _noBtn = [[JHButton alloc] initWithFrame:frame difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:WGAppFooterButtonColor];
    [_noBtn setTitle:kStr(@"CommitOrder_OverHeight_Confirm") forState:UIControlStateNormal];
    _noBtn.titleLabel.font = kAppAdaptFont(12);
    [_noBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_noBtn addTarget:self action:@selector(touchNoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_noBtn];
    _noBtn.hidden = YES;
    
    _noUnableBtn = [[JHButton alloc] initWithFrame:frame difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:kHRGB(0xB0BEC5)];
    [_noUnableBtn setTitle:kStr(@"CommitOrder_OverHeight_Confirm") forState:UIControlStateNormal];
    _noUnableBtn.titleLabel.font = kAppAdaptFont(12);
    [_noUnableBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_contentView addSubview:_noUnableBtn];
    _noUnableBtn.hidden = YES;
}

- (void)setCurrentRiseLabel {
    WGOverHeightDetail *detail = _detailArray[0];
    _currentRaseLabel.text = [NSString stringWithFormat:kStr(@"CommitOrder_OverHeight_CurrentRise"), detail.currentRise, kStr(@"CommitOrder_OverHeight_Rise")];
    [_currentRaseLabel setPartString:[NSString stringWithFormat:@"%.2f%@", detail.currentRise, kStr(@"CommitOrder_OverHeight_Rise")] attributes:@{NSFontAttributeName : kAppAdaptFont(18)}];
    _currentRaseLabel.backgroundColor = (detail.maxRise.floatValue >= detail.currentRise) ? kHRGB(0X019084) : kHRGB(0XD80027);
    [_currentRaseLabel sizeToFit];
    _currentRaseLabel.layer.cornerRadius = kAppAdaptWidth(3);
    _currentRaseLabel.layer.masksToBounds = YES;
    _currentRaseLabel.width = _currentRaseLabel.width + kAppAdaptWidth(30);
    _currentRaseLabel.center = CGPointMake(_contentView.width/2, _currentRaseLabel.y + _currentRaseLabel.height/2);
}

- (void)setNoButton {
    WGOverHeightDetail *detail = _detailArray[0];
    BOOL displayComfirm = (detail.maxRise.floatValue >= detail.currentRise);
    _noUnableBtn.hidden = displayComfirm;
    _noBtn.hidden = !displayComfirm;
}

- (void)touchCloseBtn:(JHButton *)sender {
    //[self close];
}

- (void)touchOkBtn:(JHButton *)sender {
    //request
    if (self.onDelete) {
        self.onDelete(_detailArray);
    }
}

- (void)touchNoBtn:(JHButton *)sender {
    BOOL canConfirm = YES;
    for (WGOverHeightDetail *item in _detailArray) {
        if (item.maxRise.floatValue - item.currentRise < 0) {
            canConfirm = NO;
            break;
        }
    }
    if (canConfirm) {
        if (self.onConfirm) {
            self.onConfirm(_detailArray);
        }
    }
}

- (void)handleGoodItem:(WGOverHeightGoodItem *)item {
    for (WGOverHeightDetail *detail in _detailArray) {
        for (WGOverHeightGoodItem *goodItem in detail.goods) {
            if (item.id == goodItem.id) {
                goodItem.goodCount = item.goodCount;
                break;
            }
        }
    }
    [self setCurrentRiseLabel];
    [self setNoButton];
    [_scrollView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WGOverHeightDetail *detail = _detailArray[section];
    return detail.goods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WGOverHeightDetail *detail = _detailArray[indexPath.section];
    if (detail && detail.goods.count > 0) {
        return kAppAdaptHeight(124);
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    WGOverHeightGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    WeakSelf;
    if (!cell) {
        cell = [[WGOverHeightGoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.onAdd = ^(WGOverHeightGoodItem *item) {
            [weakSelf handleGoodItem:item];
        };
        cell.onSub = ^(WGOverHeightGoodItem *item) {
            [weakSelf handleGoodItem:item];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
        line.backgroundColor = WGAppSeparateLineColor;
        [cell.contentView addSubview:line];
        cell.contentView.clipsToBounds = YES;
        cell.clipsToBounds = YES;
    }
    WGOverHeightDetail *detail = _detailArray[0];
    [cell showWithData:detail.goods[indexPath.row]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WGOverHeightDetail *detail = _detailArray[indexPath.section];
        WGOverHeightGoodItem *item = detail.goods[indexPath.row];
        item.goodCount = 0;
        [tableView reloadData];
        [self setCurrentRiseLabel];
    }
}

@end

