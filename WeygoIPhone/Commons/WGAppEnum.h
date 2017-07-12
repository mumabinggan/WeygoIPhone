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
    WGTabIndexBenefit,
    WGTabIndexAsia,
    WGTabIndexMine,
};

typedef NS_ENUM(NSInteger, WGLoginType) {
    WGLoginTypeNormal,
    WGLoginTypeGoodDetailFavorite,
    WGLoginTypeShopCart,
    WGLoginTypeOpenSlider,
    WGLoginTypeInvitation,
};

typedef NS_ENUM(NSInteger, WGAppJumpType) {
    WGAppJumpTypeNone,
    WGAppJumpTypeRegister,          //注册
    WGAppJumpTypeGoodDetail,        //商品详情
    WGAppJumpTypeInvitation,        //邀请
    WGAppJumpTypeClassifyDetail,    //分类详情
    WGAppJumpTypeSpecailClassifyHomeTab,    //特殊专题:Home Tab
    WGAppJumpTypeSpecailClassifyGoodBenefitTab, //特殊专题（只显示商品）：Benefit Tab
    WGAppJumpTypeSpecailClassifyNoTab,          //没有 Tab 的特殊专题
    WGAppJumpTypeSpecailClassifyGoodNoTab,      //没有 Tab 的特殊专题（只显示商品）
};

typedef NS_ENUM(NSInteger, WGClassifyJumpType) {
    WGClassifyJumpTypeNone,
    WGClassifyJumpTypeClassifyDetail = WGAppJumpTypeClassifyDetail,
    WGClassifyJumpTypeSpecailClassifyHomeTab = WGAppJumpTypeSpecailClassifyHomeTab,
    WGClassifyJumpTypeSpecailClassifyGoodBenefitTab = WGAppJumpTypeSpecailClassifyGoodBenefitTab,
    WGClassifyJumpTypeSpecailClassifyNoTab = WGAppJumpTypeSpecailClassifyNoTab,
    WGClassifyJumpTypeSpecailClassifyGoodNoTab = WGAppJumpTypeSpecailClassifyGoodNoTab,
};

typedef NS_ENUM(NSInteger, WGRefreshNotificationType) {
    WGRefreshNotificationTypeNone,
    WGRefreshNotificationTypeLogin,
    WGRefreshNotificationTypeLogout,
    WGRefreshNotificationTypeChangeAddress,
};

typedef NS_ENUM(NSInteger, WGIntegrationState) {
    WGIntegrationStateNoUse = 0,
    WGIntegrationStateUse,
};

typedef NS_ENUM(NSInteger, WGThirdPartyLoginType) {
    WGThirdPartyLoginTypeFacebook = 1,
    WGThirdPartyLoginTypeWechat,
};

typedef NS_ENUM(NSInteger, WGCacheType) {
    WGCacheTypeCacheBoth,
    WGCacheTypeCachePrior,
    WGCacheTypeNetwork,
};

#endif /* WGAppEnum_h */
