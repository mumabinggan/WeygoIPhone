//
//  WGCSCCommonItemRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRequest.h"

typedef NS_ENUM(NSInteger, LFCSCItemType) {
    LFCSCItemTypeChiSiamo = 0,
    LFCSCItemTypeComeFunziona = 1,
    LFCSCItemTypeContatti,
    LFCSCItemTypeFAQ,       //无效
    LFCSCItemTypeAiutaciAMigliorare,
    LFCSCItemTypeCondizioniGenerali,
    LFCSCItemTypeGaranziaLegale,
    LFCSCItemTypePrivacyECookies,
    LFCSCItemTypeSuggerimenti,
};

@interface WGCSCCommonItemRequest : WGRequest

@property (nonatomic, assign) LFCSCItemType type;

@end
