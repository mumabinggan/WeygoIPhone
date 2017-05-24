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
//#define kWGSideBarWidth kW


//#define kWGOswaldMediumFont(fsize)    kAppFont(fsize)
//#define kWGOswaldMediumAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGSFUIDisplaySemiBoldFont(fsize)    kAppFont(fsize)
#define kWGSFUIDisplaySemiBoldAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGSFUIDisplayRegularFont(fsize)    kAppFont(fsize)
#define kWGSFUIDisplayRegularAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGSFUIDisplayMediumFont(fsize)    kAppFont(fsize)
#define kWGSFUIDisplayMediumAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGSFUIDisplayBoldFont(fsize)    kAppFont(fsize)
#define kWGSFUIDisplayBoldAdaptFont(fsize)    kAppAdaptFont(fsize)

#define kWGOswaldRegularFont(fsize)    kFont(fsize, @"Oswald-Regular")
#define kWGOswaldRegularAdaptFont(fsize)    kWGOswaldRegularFont(fsize * kDeviceWidthScaleTo47Inch)




#define kWGOswaldMediumFont(fsize)    kFont(fsize, @"Oswald-Medium");
#define kWGOswaldMediumAdaptFont(fsize)    kWGOswaldMediumFont(fsize * kDeviceWidthScaleTo47Inch)
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
static NSString *kNotificationUpdateShopCartCount = @"kNotificationUpdateShopCartCount";
static NSString *kNotificationLogIn = @"kNotificationLogIn";
static NSString *kNotificationLogOut = @"kNotificationLogOut";
static NSString *kNotificationServiceLoad = @"kNotificationServiceLoad";

static float kNavigationY = 64;

//Local Setting
#define kLocalSettingsKeyUser   @"kLocalSettingsKeyUser"
#define kLocalSettingsKeyUnLoginCap   @"kLocalSettingsKeyUnLoginCap"
#define kLocalSettingsLocalCartGoods    @"kLocalSettingsLocalCartGoods"
#define kLocalSettingsLocalLanguage    @"kLocalSettingsLocalLanguage"
#define kLocalSettingsLocalSearchHistory(userId)            ([NSString stringWithFormat:@"kLocalSettingsLocalSearchHistory_%lld", userId])

//Placeholder UIImage

#define kHomeTopicPlaceholderImage [UIImage imageNamed:@"image_loading_small"]

#define kHomeFloorPictureHeaderPlaceholderImage [UIImage imageNamed:@"image_loading_floor"]

#define kHomeCarouselPictureHeaderPlaceholderImage [UIImage imageNamed:@"image_loading_carousel"]

#define kHomeGoodListPlaceholderImage [UIImage imageNamed:@"image_loading_small"]
#define kHomeGoodColumnPlaceholderImage [UIImage imageNamed:@"image_loading_small"]
#define kHomeGoodGridPlaceholderImage [UIImage imageNamed:@"image_loading_small"]
#define kHomeClassifyGridPlaceholderImage [UIImage imageNamed:@"image_loading_small"]
#define kHomeClassifyColumnPlaceholderImage [UIImage imageNamed:@"image_loading_small"]
#define kHomeClassifyListPlaceholderImage [UIImage imageNamed:@"image_loading_small"]
#define kHomeCountryPlaceholderImage [UIImage imageNamed:@"image_loading_small"]

#define kClassifyGoodListClassifyPlaceholderImage [UIImage imageNamed:@"image_loading_small"]

#define kClassifyClassifyPlaceholderImage [UIImage imageNamed:@"image_loading_small"]

#define kInvitationPlaceholderImage [UIImage imageNamed:@"image_loading_carousel"]

#define kShopCartGiftPlaceholderImage [UIImage imageNamed:@"image_loading_small"]

#endif /* WGAppConstants_h */
