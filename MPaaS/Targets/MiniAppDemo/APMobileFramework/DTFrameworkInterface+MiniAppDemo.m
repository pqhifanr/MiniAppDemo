//
//  DTFrameworkInterface+MiniAppDemo.m
//  MiniAppDemo
//
//  Created by quanhua.peng on 2020/10/29.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import "DTFrameworkInterface+MiniAppDemo.h"
#import "MPBootLoaderImpl.h"
#import "AppDelegate.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation DTFrameworkInterface (MiniAppDemo)

- (BOOL)shouldLogReportActive
{
    return YES;
}

- (NSTimeInterval)logReportActiveMinInterval
{
    return 0;
}

- (BOOL)shouldLogStartupConsumption
{
    return YES;
}

- (BOOL)shouldAutoactivateBandageKit
{
    return YES;
}

- (BOOL)shouldAutoactivateShareKit
{
    return YES;
}

- (DTNavigationBarBackTextStyle)navigationBarBackTextStyle
{
    return DTNavigationBarBackTextStyleAlipay;
}

- (void)application:(UIApplication *)application beforeDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 小程序初始化，必须在before方法，否则不生效
    [MPNebulaAdapterInterface initNebulaWithCustomPresetApplistPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"MPCustomPresetApps.bundle/h5_json.json"] ofType:nil] customPresetAppPackagePath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"MPCustomPresetApps.bundle"] ofType:nil] customPluginsJsapisPath:[NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"MPCustomPluginsJsapis.bundle/Poseidon-UserDefine-Extra-Config.plist"]];
//
    [MPNebulaAdapterInterface shareInstance].configDelegate = self;
}

- (void)application:(UIApplication *)application afterDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 配置容器，必须在after方法，否则会被容器默认配置覆盖
    [MPNebulaAdapterInterface shareInstance].nebulaVeiwControllerClass = NSClassFromString(@"MPH5WebViewController");
    [MPNebulaAdapterInterface shareInstance].nebulaNeedVerify = NO;
    [MPNebulaAdapterInterface shareInstance].nebulaUserAgent = @"mPaaS/Portal";
    [MPNebulaAdapterInterface shareInstance].nebulaCommonResourceAppList = @[@"77777777"];
    [[MPNebulaAdapterInterface shareInstance] requestAllNebulaApps:^(NSDictionary *data, NSError *error) {
        NSLog(@"");
    }];
    
    UIViewController *vc = [[MPNebulaAdapterInterface shareInstance] createH5ViewControllerWithNebulaApp:@{@"appId":@"2020102100000000"}];
    [[AppDelegate sharedInstance].navigationController setViewControllers:@[vc]];
    
    // 工具类初始化
//    [MPUtils shareInstance];
}

- (DTBootLoader *)bootLoader {
    static MPBootLoaderImpl *_bootLoader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bootLoader = [[MPBootLoaderImpl alloc] init];
    });
    return _bootLoader;
}

- (BOOL)shouldWindowMakeVisable {
    return NO;
}

- (BOOL)shouldShowLauncher {
    return NO;
}

- (NSDictionary *)nebulaCustomConfig
{
    return @{@"h5_tinyAppTitleViewAlignLeftConfig" : @"{\"enable\":\"NO\"}"};
}

@end

#pragma clang diagnostic pop
