//
//  WGCommitOrderRequest.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGuestRequest.h"

@interface WGCommitOrderRequest : WGGuestRequest

//地址
@property (nonatomic, assign) long long addressId;

//发票
@property (nonatomic, assign) long long useBilling; //1:用 ： 0 ：不用

@property (nonatomic, strong) NSString *billingCompanyName;

@property (nonatomic, strong) NSString *billingCountry;

@property (nonatomic, strong) NSString *billingPhone;

@property (nonatomic, strong) NSString *billingAddress;

@property (nonatomic, strong) NSString *billingCivico;

@property (nonatomic, strong) NSString *billingCity;

@property (nonatomic, strong) NSString *billingCap;

@property (nonatomic, strong) NSString *billingProvince;

@property (nonatomic, strong) NSString *billingTaxCode;

//时间
@property (nonatomic, strong) NSString *deliverDate;
@property (nonatomic, strong) NSString *deliverTime;

//支付
@property (nonatomic, strong) NSString *payMethod;

//使用积分
@property (nonatomic, assign) int useIntegral;      //1:使用 0:不使用

@property (nonatomic, assign) long long couponId;

@property (nonatomic, strong) NSString *couponCode;

@property (nonatomic, strong) NSString *comments;

@end
