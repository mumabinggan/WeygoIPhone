//
//  WGInvitationViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGInvitationViewController.h"
#import "WGInvitationViewController+Request.h"

@interface WGInvitationViewController ()
{
    JHTableView *_tableView;
    JHImageView *_imageView;
    JHLabel *_imageLabel;
    JHLabel *_desLabel;
    JHButton *_commitBtn;
}
@end

@interface WGInvitationViewController (TableViewDelegate) <UITableViewDelegate>

@end

@implementation WGInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadInvitationDescription];
}

//- (void)initData {
//    _data = [[WGInvitationDescription alloc] init];
//    _data.imageText = @"asdfasdfasdfasd";
//    _data.detailText = @"https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=dadfasd&rsv_pq=9581a13e0001efcb&rsv_t=1586Hg95MwdLFxpRVv9aKhQz38mdAAghuVvm0EhUCHA7dejZcknovBxfik8&rqlang=cn&rsv_enter=1&rsv_sug3=7&rsv_sug2=0&inputT=804&rsv_sug4=805";
//    _data.imageURL = @"https://imgwater-test.oss.aliyuncs.com/b9831974f70a4108b2bdfcde5c241a22";
//}

- (void)initSubView {
    [super initSubView];
    self.title = kStr(@"Invitation_Title");
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    [contentView addSubview:_tableView];
    _tableView.layer.opacity= 0.0f;
//    _tableView.tableHeaderView = [self createHeaderView];
//    _tableView.tableFooterView = [self createFooterView];
}

- (UIView *)createHeaderView {
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(136))];
    [_imageView setImageWithURL:[NSURL URLWithString:_data.imageURL] placeholderImage:kInvitationPlaceholderImage options:JHWebImageOptionsRefreshCached];
    
    _imageLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, _imageView.width, _imageView.height)];
    _imageLabel.font = kAppAdaptFont(16);
    _imageLabel.textColor = kWhiteColor;
    _imageLabel.textAlignment = NSTextAlignmentCenter;
    _imageLabel.text = _data.imageText;
    _imageLabel.numberOfLines = 0;
    [_imageView addSubview:_imageLabel];
    
    return _imageView;
}

- (JHView *)createFooterView {
    JHView *footerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - kAppAdaptHeight(136))];
    _desLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(20), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _desLabel.font = kAppAdaptFont(14);
    _desLabel.textColor = WGAppTitleColor;
    _desLabel.numberOfLines = 0;
    _desLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:_desLabel];
    CGSize size = [_data.detailText returnSize:_desLabel.font maxWidth:_desLabel.width];
    _desLabel.height = size.height;
    
    _emailTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _desLabel.maxY + kAppAdaptHeight(20), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(32))];
    _emailTextField.layer.cornerRadius = kAppAdaptWidth(16);
    _emailTextField.layer.masksToBounds = YES;
    _emailTextField.layer.borderWidth = kAppSepratorLineHeight;
    _emailTextField.layer.borderColor = WGAppLightNameLabelColor.CGColor;
    _emailTextField.backgroundColor = WGAppSeparateLineColor;
    _emailTextField.textColor = kBlackColor;
    _emailTextField.placeholder = kStr(@"Invitation_Input_HolderPlace");
    _emailTextField.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:_emailTextField];
    
    JHButton *commitBtn = [[JHButton alloc] initWithFrame:CGRectMake((kDeviceWidth - kAppAdaptWidth(128))/2, kAppAdaptHeight(30) + _emailTextField.maxY, kAppAdaptWidth(128), kAppAdaptHeight(32)) difRadius:JHRadiusMake(kAppAdaptHeight(16), kAppAdaptHeight(16), kAppAdaptHeight(16), kAppAdaptHeight(16)) backgroundColor:WGAppBlueButtonColor];
    [commitBtn addTarget:self action:@selector(touchCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitle:kStr(@"Invitation_Commit") forState:UIControlStateNormal];
    [commitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    commitBtn.titleLabel.font = kAppAdaptFont(14);
    [footerView addSubview:commitBtn];
    
    _imageLabel.text = _data.imageText;
    _desLabel.text = _data.detailText;
    
    return footerView;
}

- (void)touchCommitBtn:(JHButton *)sender {
    if ([NSString isNullOrEmpty:_emailTextField.text]) {
        [self showWarningMessage:kStr(@"Invitation_Input_EmptyTip")];
        return;
    }
    [self loadInvitationRequest];
}

- (void)refreshUI {
    _tableView.tableHeaderView = [self createHeaderView];
    _tableView.tableFooterView = [self createFooterView];
    [UIView animateWithDuration:0.25 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGInvitationViewController (TableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

@end
