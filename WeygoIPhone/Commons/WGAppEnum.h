//
//  WGAppEnum.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#ifndef WGAppEnum_h
#define WGAppEnum_h

typedef NS_ENUM(NSInteger, WGTabIndex) {
    WGTabIndexHome = 0,
    WGTabIndexClassify,
    WGTabIndexShopCart,
    WGTabIndexBenefit,
    WGTabIndexMine,
};

typedef NS_ENUM(NSInteger, WGLoginType) {
    WGLoginTypeNormal,
    WGLoginTypeGoodDetailFavorite,
    WGLoginTypeShopCart,
    WGLoginTypeOpenSlider,
};

typedef NS_ENUM(NSInteger, WGClassifyJumpType) {
    WGClassifyJumpTypeNone,
    WGClassifyJumpTypeClassifyDetail,
    WGClassifyJumpTypeSpecailClassify,
    WGClassifyJumpTypeSpecailClassifyGood,
};

typedef NS_ENUM(NSInteger, WGRefreshNotificationType) {
    WGRefreshNotificationTypeNone,
    WGRefreshNotificationTypeLogin,
    WGRefreshNotificationTypeLogout,
    WGRefreshNotificationTypeChangeAddress,
};

#endif /* WGAppEnum_h */
