//
//  WGAppConstants.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#ifndef WGAppConstants_h
#define WGAppConstants_h

#define WGAppIdKey      @"appid"
#define WGAppIdValue    @"MOBILE_APPS"
#define WGAppkeyKey     @"appkey"
#define WGAppkeyValue   @"JXEENBJCB8A3SEBZA"

#define WGAppBaseColor  kHRGB(0XEE7A3C)
#define WGAppNameLabelColor  kRGBA(0, 0, 0, 0.87)
#define WGAppTitleColor  kRGBA(0, 0, 0, 0.54)
#define WGAppLightNameLabelColor  kRGBA(0, 0, 0, 0.38)
#define WGAppSeparateLineColor kRGBA(0, 0, 0, 0.12)

#define WGAppBlueButtonColor kHRGB(0x5677FC)

#define WGAppFooterButtonColor kRGB(86, 119, 252)

#define kWGSideBarWidth  kAppAdaptWidth(280)

#define kWGOswaldMediumFont(fsize)    kAppFont(fsize)
#define kWGOswaldMediumAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGSFUIDisplaySemiBoldFont(fsize)    kAppFont(fsize)
#define kWGSFUIDisplaySemiBoldAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGSFUIDisplayRegularFont(fsize)    kAppFont(fsize)
#define kWGSFUIDisplayRegularAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGSFUIDisplayMediumFont(fsize)    kAppFont(fsize)
#define kWGSFUIDisplayMediumAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGSFUIDisplayBoldFont(fsize)    kAppFont(fsize)
#define kWGSFUIDisplayBoldAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGOswaldRegularFont(fsize)    kAppFont(fsize)
#define kWGOswaldRegularAdaptFont(fsize)    kAppAdaptFont(fsize)




//#define kWGOswaldMediumFont(fsize)    kFont(fsize, @"Oswald-Medium");
//#define kWGOswaldMediumAdaptFont(fsize)    kWGOswaldMediumFont(fsize * kDeviceWidthScaleTo47Inch)
//
//#define kWGSFUIDisplaySemiBoldFont(fsize)    kFont(fsize, @"SF-UI-Display-Semibold")
//#define kWGSFUIDisplaySemiBoldAdaptFont(fsize)    kWGSFUIDisplaySemiBoldFont(fsize * kDeviceWidthScaleTo47Inch)
//
//#define kWGSFUIDisplayRegularFont(fsize)    kFont(fsize, @"SF-UI-Display-Regular")
//#define kWGSFUIDisplayRegularAdaptFont(fsize)    kWGSFUIDisplayRegularFont(fsize * kDeviceWidthScaleTo47Inch)
//
//#define kWGSFUIDisplayMediumFont(fsize)    kFont(fsize, @"SF-UI-Display-Medium")
//#define kWGSFUIDisplayMediumAdaptFont(fsize)    kWGSFUIDisplayMediumFont(fsize * kDeviceWidthScaleTo47Inch)
//
//#define kWGSFUIDisplayBoldFont(fsize)    kFont(fsize, @"SF-UI-Display-Bold")
//#define kWGSFUIDisplayBoldAdaptFont(fsize)    kWGSFUIDisplayBoldFont(fsize * kDeviceWidthScaleTo47Inch)
//
//#define kWGOswaldRegularFont(fsize)    kFont(fsize, @"Oswald-Regular")
//#define kWGOswaldRegularAdaptFont(fsize)    kWGOswaldRegularFont(fsize * kDeviceWidthScaleTo47Inch)

static NSString *kNotificationTabChanged = @"kNotificationTabChanged";

//Local Setting
#define kLocalSettingsKeyUser   @"kLocalSettingsKeyUser"
#define kLocalSettingsKeyUnLoginCap   @"kLocalSettingsKeyUnLoginCap"
#define kLocalSettingsLocalCartGoods    @"kLocalSettingsLocalCartGoods"


//Placeholder UIImage

#define kLoginVerificationCodePlaceholderImage [UIImage imageNamed:@""]
#define kMineHeaderPlaceholderImage [UIImage imageNamed:@""]
#define kPersonInfoHeaderPlaceholderImage [UIImage imageNamed:@""]

#define kHomeTopicPlaceholderImage [UIImage imageNamed:@""]

#define kHomeFloorPictureHeaderPlaceholderImage [UIImage imageNamed:@""]

#define kHomeGoodListPlaceholderImage [UIImage imageNamed:@""]
#define kHomeGoodColumnPlaceholderImage [UIImage imageNamed:@""]
#define kHomeGoodGridPlaceholderImage [UIImage imageNamed:@""]
#define kHomeClassifyGridPlaceholderImage [UIImage imageNamed:@""]
#define kHomeClassifyColumnPlaceholderImage [UIImage imageNamed:@""]
#define kHomeClassifyListPlaceholderImage [UIImage imageNamed:@""]
#define kHomeCountryPlaceholderImage [UIImage imageNamed:@""]

#define kClassifyGoodListClassifyPlaceholderImage [UIImage imageNamed:@""]

#define kClassifyClassifyPlaceholderImage [UIImage imageNamed:@""]

#define kInvitationPlaceholderImage [UIImage imageNamed:@""]

#define kShopCartGiftPlaceholderImage [UIImage imageNamed:@""]

#endif /* WGAppConstants_h */
