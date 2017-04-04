//
//  WGEditAddressViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditAddressViewController.h"

@interface WGEditAddressViewController ()

@end

@implementation WGEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _placeholderArray = [NSArray arrayWithObjects:
                         kStr(@"Cognome"),
                         kStr(@"Nome"),
                         kStr(@"Italia"),
                         kStr(@"Indirizzo"),
                         kStr(@"Telefono/Cellulare"),
                         kStr(@"Citta"),
                         kStr(@"CAP"),
                         kStr(@"Indirizzo"),
                         kStr(@"Numero civico"),
                         kStr(@"Scala"),
                         kStr(@"Ascensore"),
                         kStr(@"Piano"),
                         nil];
    _contentMArray = [NSMutableArray arrayWithObjects:
                      [NSString safeString:_address.companyName],
                      [NSString safeString:_address.name],
                      [NSString safeString:_address.country],
                      [NSString safeString:_address.phone],
                      [NSString safeString:_address.cap],
                      [NSString safeString:_address.city],
                      [NSString safeString:_address.address],
                      [NSString safeString:_address.streetNumber],
                      [NSString safeString:_address.citofono],
                      [NSString safeString:_address.scala],
                      @(_address.ascensore).stringValue,
                      [NSString safeString:_address.piano],
                      nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
