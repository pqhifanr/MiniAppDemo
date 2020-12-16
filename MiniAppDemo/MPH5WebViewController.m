//
//  MPH5WebViewController.m
//  MPTinyAppDemo_pod
//
//  Created by quanhua on 2020/10/28.
//  Copyright © 2020 yangwei. All rights reserved.
//

#import "MPH5WebViewController.h"
#import <TinyappService/TASUtils.h>

@interface MPH5WebViewController ()

@end

@implementation MPH5WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDictionary *expandParams = self.psdScene.createParam.expandParams;
    NSLog(@"expandParams: %@", expandParams);
    if ([expandParams count] > 0) {
        [self customNavigationBarWithParams:expandParams];
    }
    
    [TASUtils sharedInstance].shoulShowSettingMenu = NO;
//    [self.navigationItem.rightBarButtonItem setEnabled:NO];
//    [self.navigationItem.rightBarButtonItem setTitle:@""];
//    [self.navigationItem.rightBarButtonItem setImage:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(onClickClose)];
    
}

- (void)onClickClose {
    [self callHandler:@"nativeToTiny" data:@{@"key":@"value"} responseCallback:^(id responseData) {
        NSLog(@"hello");
     }];
}

- (void)customNavigationBarWithParams:(NSDictionary *)expandParams {
    
    
    // 设置当前页面标题颜色
    id titleColorString = expandParams[@"titleColor"];
    UIColor *titleColor = nil;
    if (titleColorString > 0) {
        titleColor = [UIColor colorWithRGB_au:titleColorString];
    } else if ([titleColorString isKindOfClass:[NSString class]] && [titleColorString length] > 0) {
        titleColor = [UIColor colorFromHexString_au:titleColorString];
    }
    if (titleColor) {
        id<NBNavigationTitleViewProtocol> titleView = self.navigationItem.titleView;
        [[titleView mainTitleLabel] setFont: [UIFont systemFontOfSize:16]];
        [[titleView mainTitleLabel] setTextColor: [UIColor redColor]];
    }
}

@end
