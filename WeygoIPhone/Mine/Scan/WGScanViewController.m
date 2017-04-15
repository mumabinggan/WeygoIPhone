//
//  WGScanViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGScanViewController.h"
#import "WGScanCodeView.h"
#import "WGScanJump.h"
#import "WGGoodDetailViewController.h"
#import "WGClassifyDetailViewController.h"
#import "WGSpecialClassifyViewController.h"
#import "WGSpecialClassifyGoodViewController.h"
#import "WGHomeTabViewController.h"
#import "WGTabBenefitViewController.h"

@interface WGScanViewController ()

@end

@implementation WGScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    [super initSubView];
    WeakSelf;
    WGScanCodeView *scanCodeView = [[WGScanCodeView alloc] initWithFrame:self.view.bounds];
    scanCodeView.onSuccess = ^(NSString *resultString) {
        [weakSelf handleScan:resultString];
    };
    [self.view addSubview:scanCodeView];
}

- (void)handleScan:(NSString *)resultString {
    DLog(@"-----resultString--%@", resultString);
    WGScanJump *scanJump = [[WGScanJump alloc] initWithJSON:resultString];
    WGViewController *vc = [[WGViewController alloc] init];
    if (scanJump && scanJump.weygo) {
        if (scanJump.weygo.type == WGScanJumpTypeGood) {
            WGScanJumpGood *item = (WGScanJumpGood *)(scanJump.weygo.bodyContent);
            WGGoodDetailViewController *goodVC = [[WGGoodDetailViewController alloc] init];
            goodVC.goodId = item.id;
            vc = goodVC;
        }
        else if (scanJump.weygo.type == WGScanJumpTypeClassify) {
            WGScanJumpClassify *item = (WGScanJumpClassify *)(scanJump.weygo.bodyContent);
            if (item.jumpType == WGClassifyJumpTypeClassifyDetail) {
                WGClassifyDetailViewController *classifyVC = [[WGClassifyDetailViewController alloc] init];
                classifyVC.classifyId = item.id;
                vc = classifyVC;
            }
            else if (item.jumpType == WGClassifyJumpTypeSpecailClassifyNoTab) {
                WGSpecialClassifyViewController *specialVC = [[WGSpecialClassifyViewController alloc] init];
                specialVC.id = item.id;
                vc = specialVC;
            }
            else if (item.jumpType == WGClassifyJumpTypeSpecailClassifyGoodNoTab) {
                WGSpecialClassifyGoodViewController *specialGoodVC = [[WGSpecialClassifyGoodViewController alloc] init];
                specialGoodVC.id = item.id;
                vc = specialGoodVC;
            }
            else if (item.jumpType == WGClassifyJumpTypeSpecailClassifyHomeTab) {
                WGApplication *application = [WGApplication sharedApplication];
                WGHomeTabViewController *homeViewController = application.homeTabViewController;
                homeViewController.currentId = item.id;
                [application switchTab:WGTabIndexHome];
            }
            else if (item.jumpType == WGClassifyJumpTypeSpecailClassifyGoodBenefitTab) {
                WGApplication *application = [WGApplication sharedApplication];
                WGTabBenefitViewController *benefitViewController = application.benefitTabViewController;
                benefitViewController.currentId = item.id;
                [application switchTab:WGTabIndexHome];
            }
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [array removeLastObject];
            [array addObject:vc];
            [self.navigationController setViewControllers:array animated:YES];
        }
        
    }
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
