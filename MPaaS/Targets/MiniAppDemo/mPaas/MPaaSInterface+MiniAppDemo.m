//
//  MPaaSInterface+MiniAppDemo.m
//  MiniAppDemo
//
//  Created by quanhua.peng on 2020/10/29.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import "MPaaSInterface+MiniAppDemo.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation MPaaSInterface (MiniAppDemo)

- (BOOL)enableSettingService
{
    return NO;
}

- (NSString *)userId
{
    return nil;
}

@end

#pragma clang diagnostic pop
