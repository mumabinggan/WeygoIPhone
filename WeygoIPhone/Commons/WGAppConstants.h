//
//  WGAppConstants.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#ifndef WGAppConstants_h
#define WGAppConstants_h

#define WGAppBaseColor  kRGB(233, 122, 60)
#define WGAppTitleColor  kRGBA(0, 0, 0, 0.54)

#define kWGSideBarWidth  (kDeviceWidth * 2.0/3.0)

#define kWGOswaldMediumFont(fsize)    kFont(fsize, @"Oswald-Medium");
#define kWGOswaldMediumAdaptFont(fsize)    kWGOswaldMediumFont(fsize * kDeviceWidthScaleTo47Inch)

#define kWGSFUIDisplaySemiBoldFont(fsize)    kFont(fsize, @"SF-UI-Display-Semibold")
#define kWGSFUIDisplaySemiBoldAdaptFont(fsize)    kWGSFUIDisplaySemiBoldFont(fsize * kDeviceWidthScaleTo47Inch)

#define kWGSFUIDisplayRegularFont(fsize)    kFont(fsize, @"SF-UI-Display-Regular")
#define kWGSFUIDisplayRegularAdaptFont(fsize)    kWGSFUIDisplayRegularFont(fsize * kDeviceWidthScaleTo47Inch)

#define kWGOswaldRegularFont(fsize)    kFont(fsize, @"Oswald-Regular")
#define kWGOswaldRegularAdaptFont(fsize)    kWGOswaldRegularFont(fsize * kDeviceWidthScaleTo47Inch)

//Notification







//Placeholder UIImage

#define kHomeTopicPlaceholderImage [UIImage imageNamed:@""]

#define kHomeGoodListPlaceholderImage [UIImage imageNamed:@""]
#define kHomeGoodColumnPlaceholderImage [UIImage imageNamed:@""]
#define kHomeGoodGridPlaceholderImage [UIImage imageNamed:@""]
#define kHomeClassifyGridPlaceholderImage [UIImage imageNamed:@""]
#define kHomeClassifyColumnPlaceholderImage [UIImage imageNamed:@""]
#define kHomeCountryPlaceholderImage [UIImage imageNamed:@""]

#endif /* WGAppConstants_h */
