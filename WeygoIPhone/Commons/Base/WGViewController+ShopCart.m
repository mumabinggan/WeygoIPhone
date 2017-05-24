//
//  WGTabViewController+ShopCart.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController+ShopCart.h"
#import <objc/runtime.h>
#import "WGApplication+Controller.h"
#import "WGShopCartViewController.h"

static const NSString *WGShopCartButtonKey = @"WGShopCartButtonKey";
static const NSString *WGShopCartRightItemKey = @"WGShopCartRightItemKey";

@implementation WGViewController (ShopCart)

//+ (void)load {
//    [super load];
//    // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
//    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
//    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
//    /**
//     *  我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
//     *  而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
//     *  所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
//     */
//    if (!class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
//        method_exchangeImplementations(fromMethod, toMethod);
//    }
//}
//
//// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
//- (void)swizzlingViewDidLoad {
//    NSString *str = [NSString stringWithFormat:@"%@", self.class];
//    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
//    if(![str containsString:@"UI"]){
//        NSLog(@"统计打点 : %@", self.class);
//    }
//    [self swizzlingViewDidLoad];
//}

+ (void)load {
    [self lf_swizzle:@selector(viewDidLoad)];
}

+ (void)lf_swizzle:(SEL)aSelector
{
    SEL bSelector = NSSelectorFromString([NSString stringWithFormat:@"lf_%@", NSStringFromSelector(aSelector)]);
    
    Method m1 = class_getInstanceMethod(self, aSelector);
    Method m2 = class_getInstanceMethod(self, bSelector);
    
    method_exchangeImplementations(m1, m2);
}

- (void)lf_viewDidLoad {
    [self lf_viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateShopCart:) name:kNotificationUpdateShopCartCount object:nil];
}

- (void)handleUpdateShopCart:(NSNotification *)notification {
    JHBarButtonItem *item = (JHBarButtonItem *)[self rightItem];
    if (item) {
        if (item.tag == WGRightItemTypeShopCart) {
            [item showBadge:([WGApplication sharedApplication].shopCartGoodCount > 0 ? YES : NO) withNumber:(int)[WGApplication sharedApplication].shopCartGoodCount withFrame:CGRectMake(13, 5, 17, 17)];
        }
    }
    else {
        JHButton *item = [self rightButton];
        if (item) {
            [item showBadge:([WGApplication sharedApplication].shopCartGoodCount > 0 ? YES : NO) text:@([WGApplication sharedApplication].shopCartGoodCount).stringValue];
        }
    }
    
}

- (UIBarButtonItem *)rightItem {
    return objc_getAssociatedObject(self, &WGShopCartRightItemKey);
}

- (void)setRightItem:(UIBarButtonItem *)rightItem {
    objc_setAssociatedObject(self, &WGShopCartRightItemKey, rightItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JHButton *)rightButton {
    return objc_getAssociatedObject(self, &WGShopCartButtonKey);
}

- (void)setRightButton:(UIButton *)rightButton {
    objc_setAssociatedObject(self, &WGShopCartButtonKey, rightButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JHButton *)createShopCartWithNumberButton {
    JHButton *shopCartButton = [self createShopCartButton];
    [shopCartButton addBadge];
    [shopCartButton showBadge:([WGApplication sharedApplication].shopCartGoodCount > 0 ? YES : NO) text:@([WGApplication sharedApplication].shopCartGoodCount).stringValue];
    return shopCartButton;
}

- (JHButton *)createShopCartButton {
    if (!self.rightButton) {
        JHButton *backButton = [JHButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"right_cart"] forState:UIControlStateNormal];
        [backButton setTitle:nil forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(touchShopCartButton:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitleColor:[UINavigationBar appearance].tintColor forState:UIControlStateNormal];
        [backButton sizeToFit];
        CGRect r = backButton.frame;
        r.size.height = 44;
        r.size.width += 3;
        backButton.frame = r;
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        self.rightButton = backButton;
    }
    return self.rightButton;
}

- (UIBarButtonItem *)createShopCartItem {
    if (!self.rightItem) {
        UIView *view = [self createShopCartButton];
        JHBarButtonItem *item =  [[JHBarButtonItem alloc] initWithCustomView:view];
        item.tag = WGRightItemTypeShopCart;
        [item showBadge:([WGApplication sharedApplication].shopCartGoodCount > 0 ? YES : NO) withNumber:(int)[WGApplication sharedApplication].shopCartGoodCount withFrame:CGRectMake(13, 5, 17, 17)];
        self.rightItem = item;
    }
    return self.rightItem;
}

- (void)touchShopCartButton:(JHButton *)sender {
    //self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
    WGShopCartViewController *vc = [[WGShopCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUpdateShopCartCount object:nil];
}

@end
