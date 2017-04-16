//
//  WGApplication+Operation.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication+Operation.h"
#import "WGGoodInLocalCart.h"

@implementation WGApplication (Operation)

- (NSString *)sessionKey {
    return [self user].sessionKey;
}

- (BOOL)isLogined {
    return ([self user] != nil);
}

- (BOOL)isBoy {
    if ([self user]) {
        return ([self user].sex == 1);
    }
    return NO;
}

- (BOOL)isGirl {
    if (self.user) {
        return (self.user.sex == 2);
    }
    return NO;
}

- (NSString *)userAvatar {
    if ([self isBoy]) {
        return @"slider_boy";
    }
    else if ([self isGirl]) {
        return @"slider_girl";
    }
    else {
        return @"slider_unknown";
    }
}

- (NSString *)userName {
    WGUser *user = [self user];
    if (user) {
        if ([NSString isNullOrEmpty:user.fullName]) {
            return [NSString stringWithFormat:@"%@%@", user.surname, user.name];
        }
        return user.fullName;
    }
    return nil;
}

- (WGUser *)user {
    if (!_user) {
        NSDictionary *dic = [[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsKeyUser];
        if (dic) {
            _user = [[WGUser alloc] initWithDictionary:dic error:nil];
        }
    }
    return _user;
}

- (void)setUser:(WGUser *)user {
    _user = user;
    if (user) {
        [[JHLocalSettings sharedSettings] setSettings:user.toDictionary forKey:kLocalSettingsKeyUser];
    }
    else {
        [[JHLocalSettings sharedSettings] removeSettingsForKey:kLocalSettingsKeyUser];
    }
}

- (void)setCurrentPostCode:(NSString *)currentPostCode {
    if ([self isLogined]) {
        _user.cap = currentPostCode;
        [[JHLocalSettings sharedSettings] setSettings:_user.toDictionary forKey:kLocalSettingsKeyUser];
    }
    else {
        [[JHLocalSettings sharedSettings] setSettings:currentPostCode forKey:kLocalSettingsKeyUnLoginCap];
    }
    _currentPostCode = currentPostCode;
}

- (NSString *)currentPostCode {
    if ([NSString isNullOrEmpty:_currentPostCode]) {
        if ([self isLogined]) {
            _currentPostCode = self.user.cap;
        }
        else {
            _currentPostCode = [[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsKeyUnLoginCap];
        }
    }
    return _currentPostCode;
}

- (void)setName:(NSString *)name {
    if ([self isLogined]) {
        _user.name = name;
    }
    [[JHLocalSettings sharedSettings] setSettings:_user.toDictionary forKey:kLocalSettingsKeyUser];
}

- (void)setSurname:(NSString *)surname {
    if ([self isLogined]) {
        _user.surname = surname;
    }
    [[JHLocalSettings sharedSettings] setSettings:_user.toDictionary forKey:kLocalSettingsKeyUser];
}

- (void)setSex:(int)sex {
    if ([self isLogined]) {
        _user.sex = sex;
    }
    [[JHLocalSettings sharedSettings] setSettings:_user.toDictionary forKey:kLocalSettingsKeyUser];
}

- (void)setTax:(NSString *)tax {
    if ([self isLogined]) {
        _user.tax = tax;
    }
    [[JHLocalSettings sharedSettings] setSettings:_user.toDictionary forKey:kLocalSettingsKeyUser];
}

- (void)setEmail:(NSString *)email {
    if ([self isLogined]) {
        _user.email = email;
    }
    [[JHLocalSettings sharedSettings] setSettings:_user.toDictionary forKey:kLocalSettingsKeyUser];
}

- (void)setMobile:(NSString *)mobile {
    if ([self isLogined]) {
        _user.mobile = mobile;
    }
    [[JHLocalSettings sharedSettings] setSettings:_user.toDictionary forKey:kLocalSettingsKeyUser];
}

- (void)setBirth:(NSString *)birth {
    if ([self isLogined]) {
        _user.birth = birth;
    }
    [[JHLocalSettings sharedSettings] setSettings:_user.toDictionary forKey:kLocalSettingsKeyUser];
}

- (void)reset {
    self.user = nil;
    self.currentPostCode = nil;
    [[JHLocalSettings sharedSettings] removeSettingsForKey:kLocalSettingsKeyUser];
    [[JHLocalSettings sharedSettings] removeSettingsForKey:kLocalSettingsKeyUnLoginCap];
}

- (void)addGoodToLocalCart:(WGGoodInLocalCart *)good {
    NSArray *goods = [[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsLocalCartGoods];
    NSMutableArray *goodMArray = [NSMutableArray array];
    for (NSData *item in goods) {
        WGGoodInLocalCart *cart = [[WGGoodInLocalCart alloc] initWithData:item error:nil];
        if (cart.id == good.id) {
            good.count += cart.count;
        }
        else {
            [goodMArray addObject:item];
        }
    }
    NSData *addData = [NSKeyedArchiver archivedDataWithRootObject:goods];
    [goodMArray addObject:addData];
    [[JHLocalSettings sharedSettings] setSettings:goodMArray forKey:kLocalSettingsLocalCartGoods];
}

- (NSArray *)getGoodsInLocalCart {
    NSArray *goods = [[JHLocalSettings sharedSettings] getSettingsForKey:kLocalSettingsLocalCartGoods];
    NSMutableArray *goodMArray = [[NSMutableArray alloc] init];
    for (NSData *item in goods) {
        WGGoodInLocalCart *good = [[WGGoodInLocalCart alloc] initWithData:item error:nil];
        if (good) {
            [goodMArray addObject:good];
        }
    }
    return goodMArray;
}

- (void)cleanLocalCart {
    [[JHLocalSettings sharedSettings] removeSettingsForKey:kLocalSettingsLocalCartGoods];
}

@end

@implementation WGApplication (OperationBaseService)

//Base Service
- (void)handleBaseService:(WGBaseServiceInfo *)baseServiceInfo {
    _baseServiceInfo = baseServiceInfo;
}

- (NSArray *)postcodes {
    if (_baseServiceInfo) {
        return _baseServiceInfo.postcodes;
    }
    return nil;
}

- (BOOL)supportCurrentPostCode {
    return [self supportPostcode:self.currentPostCode];
}

- (BOOL)supportPostcode:(NSString *)postCode {
    NSArray *postCodes = self.postcodes;
    if (postCodes) {
        return [postCodes containsObject:postCode];
    }
    return NO;
}

@end

@implementation WGApplication (AddShopCartAnimation)

- (void)addShopToCart:(NSString *)imageURL fromPoint:(CGPoint)fromPoint {
    [_imageView removeFromSuperview];
    _imageView = nil;
    if (!_imageView) {
        _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(fromPoint.x, fromPoint.y, kAppAdaptWidth(60), kAppAdaptWidth(60))];
        [_imageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil options:JHWebImageOptionsRefreshCached];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_imageView];
    }
    
    CABasicAnimation *theAnimation;
    theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration = 0.5;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:0];
    theAnimation.fillMode = kCAFillModeForwards;
    
    //创建一条贝塞尔
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    
    aPath.lineWidth = 1.0;//宽度
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineJoinRound;  //终点处理
    //起始点
    [aPath moveToPoint:fromPoint];
    //添加两个控制点
    [aPath addQuadCurveToPoint:CGPointMake(kDeviceWidth - 20, 40) controlPoint:CGPointMake(kDeviceWidth/2, 0)];
    //划线
    [aPath stroke];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anima.path = aPath.CGPath;
    anima.duration = 0.5f;
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    [_imageView.layer addAnimation:anima forKey:@"pathAnimation"];
    [_imageView.layer addAnimation:theAnimation forKey:@"theAnimation"];
}

@end

@implementation WGApplication (ShopCart)

- (void)setShopCartGoodCount:(long long)shopCartGoodCount {
    _shopCartGoodCount = shopCartGoodCount;
}

- (long long)shopCartGoodCount {
    return _shopCartGoodCount;
}

- (void)increaseGoodCount:(NSInteger)increaseCount {
    _shopCartGoodCount += increaseCount;
}

- (void)decreaseGoodCount:(NSInteger)decreaseCount {
    if (_shopCartGoodCount >= decreaseCount) {
        _shopCartGoodCount -= decreaseCount;
    }
}

@end
