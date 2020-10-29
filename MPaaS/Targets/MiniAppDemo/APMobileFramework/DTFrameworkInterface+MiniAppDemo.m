//
//  DTFrameworkInterface+MiniAppDemo.m
//  MiniAppDemo
//
//  Created by quanhua.peng on 2020/10/29.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import "DTFrameworkInterface+MiniAppDemo.h"

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

@end

#pragma clang diagnostic pop
