//
//  WGApplication.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "JHObject.h"
#import "WGBaseServiceResponse.h"
#import "WGUser.h"
#import "MBProgressHUD.h"
#import "WGHomeSliderResponse.h"
#import "WGReceiptCountryListResponse.h"

typedef NS_ENUM(NSInteger, WGAppLanguage) {
    WGAppLanguageItalia,
    WGAppLanguageChina,
};

@interface WGApplication : JHObject
{
    //Operation
    WGUser *_user;
    NSString *_currentPostCode;
    
    WGBaseServiceInfo *_baseServiceInfo;
    
    BOOL _loadingSliderResponse;
    WGHomeSliderResponse *_sliderResponse;
    
    BOOL _loadingReceiptCountryListResponse;
    WGReceiptCountryListResponse *_receiptCountryResponse;
    
    //ShowView
    MBProgressHUD *HUD;
    JHView *_messageView;
    
    JHImageView *_imageView;
}

@property (nonatomic, strong) WGUser *user;

@property (nonatomic, strong) NSString *currentPostCode;

//Language
@property (nonatomic, assign) WGAppLanguage currentAppLanguage;

+ (WGApplication *)sharedApplication;

@end
