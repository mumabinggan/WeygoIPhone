//
//  WGAddReceiptViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditReceiptViewController.h"
#import "WGEditReceiptCell.h"

@interface WGEditReceiptViewController ()

@end

@implementation WGEditReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _placeholderArray = [NSArray arrayWithObjects:kStr(@"Raginone sociale"), kStr(@"Italia"), kStr(@"Recapito telefonico"), kStr(@"Indirizzo"), kStr(@"N civico"), kStr(@"Citta"), kStr(@"CAP"), kStr(@"Stato"), kStr(@"Codice fiscale"), nil];
    _contentMArray = [NSMutableArray arrayWithObjects:
                     [NSString safeString:_receipt.companyName],
                     [NSString safeString:_receipt.italia],
                     [NSString safeString:_receipt.phone],
                     [NSString safeString:_receipt.address],
                     [NSString safeString:_receipt.civico],
                     [NSString safeString:_receipt.city],
                     [NSString safeString:_receipt.cap],
                     [NSString safeString:_receipt.province],
                     [NSString safeString:_receipt.taxCode], nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

