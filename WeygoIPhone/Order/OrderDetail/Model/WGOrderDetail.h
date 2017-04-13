//
//  WGOrderDetail.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGObject.h"

@class WGOrderStatus;
@class WGOrderDeliver;
@class WGOrderFax;
@class WGOrderPay;

@interface WGOrderDetail : WGObject

@property (nonatomic, assign) long long id;

@property (nonatomic, strong) NSString *sn;

@property (nonatomic, strong) WGOrderStatus *status;

@property (nonatomic, strong) WGOrderDeliver *deliver;

@property (nonatomic, strong) NSArray *goods;

@property (nonatomic, strong) WGOrderFax *fax;

@property (nonatomic, strong) NSArray *pay;

@end

@interface WGOrderStatus : WGObject

@property (nonatomic, strong) NSArray *statusArray;

@property (nonatomic, assign) NSInteger currentStatus;

@end

@interface WGOrderStatusItem : WGObject

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *statusText;

@property (nonatomic, strong) NSString *totalStatusText;

@end

@interface WGOrderDeliver : WGObject

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *userAddress;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *totalPrice;

@property (nonatomic, strong) NSString *deliverTime;

@end

@interface WGOrderFax : WGObject

@property (nonatomic, strong) NSString *companyName;

@property (nonatomic, strong) NSString *cap;

@property (nonatomic, strong) NSString *taxCode;

@end

@interface WGOrderPay : WGObject

@property (nonatomic, strong) NSString *totalPrice;

@property (nonatomic, strong) NSString *benefitPrice;

@property (nonatomic, strong) NSString *currentTotalPrice;

@end
