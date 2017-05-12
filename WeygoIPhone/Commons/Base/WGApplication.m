//
//  WGApplication.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGApplication.h"
#import "WGClassifyRequest.h"
#import "WGBaseServiceRequest.h"

@interface WGApplication ()

@end

@implementation WGApplication

static WGApplication* _sharedInstance = nil;

+ (WGApplication *)sharedApplication {
    @synchronized([WGApplication class]) {
        if(!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
            [_sharedInstance initData];
        }
        return _sharedInstance;
    }
    return nil;
}

- (void)initData {
    NSNumber *language = [[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsLocalLanguage];
    if (!language) {
        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString *languageName = [appLanguages objectAtIndex:0];
        if ([languageName containsString:@"zh-Hans"] || [languageName containsString:@"zh-Hant"] || [languageName containsString:@"zh-Hant"]) {
            [JHLocalizableManager sharedManager].type = JHLocalizableTypeChina;
        }
        else if ([languageName containsString:@"it-"]) {
            [JHLocalizableManager sharedManager].type = JHLocalizableTypeItalian;
        }
        else {
            [JHLocalizableManager sharedManager].type = JHLocalizableTypeItalian;
        }
    }
    else {
        [JHLocalizableManager sharedManager].type = language.integerValue;
    }
}

@end
