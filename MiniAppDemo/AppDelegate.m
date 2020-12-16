//
//  AppDelegate.m
//  MiniAppDemo
//
//  Created by quanhua on 2020/10/29.
//

#import "AppDelegate.h"
#import "MiniAppDemo-Bridging-Header.h"
#import "MiniAppDemo-Swift.h"
#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotificationSettings.h>
#import "MPH5WebViewController.h"
#import <UserNotifications/UNNotification.h>
#import <UserNotifications/UNNotificationContent.h>
#import <UserNotifications/UNNotificationRequest.h>
#import <UserNotifications/UNNotificationTrigger.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

+ (AppDelegate *)sharedInstance
{
    return [UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[DFNavigationController alloc] init];
    self.navigationController = self.window.rootViewController;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // navigationcontroller创建完成后，启动 mPaaS 框架
    [[DTFrameworkInterface sharedInstance] manualInitMpaasFrameworkWithApplication:application launchOptions:launchOptions];
    
    [BaaS registerWithClientID:@"a4d2d62965ddb57fa4d6" serverURLString:nil];
    [BaaS registerWechat:@"wx4b3c1aff4c5389f5" universalLink:@"https://www.ifanr.com/demo/"];
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            switch ([settings authorizationStatus]) {
                case UNAuthorizationStatusAuthorized:
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                    });
                    break;
                case UNAuthorizationStatusNotDetermined:
                    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        if (granted) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[UIApplication sharedApplication] registerForRemoteNotifications];
                            });
                        }
                    }];
                    break;
                default:
                    break;
            }
        }];
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSString *token = [self getHexStringForData:deviceToken];
    NSLog(@"token: %@", token);
    
}

- (NSString *)getHexStringForData:(NSData *)data
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
        
        if (![data isKindOfClass:[NSData class]]) {
            return @"";
        }
        NSUInteger len = [data length];
        char *chars = (char *)[data bytes];
        NSMutableString *hexString = [[NSMutableString alloc]init];
        for (NSUInteger i=0; i<len; i++) {
            [hexString appendString:[NSString stringWithFormat:@"%0.2hhx" , chars[i]]];
        }
        return hexString;
    } else {
         NSString *myToken = [[data description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
        return myToken;
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"");
    UINavigationController *navigationController = AppDelegate.sharedInstance.window.rootViewController;
    MPH5WebViewController *viewController = navigationController.topViewController;
    [viewController callHandler:@"nativeToTiny" data:@{@"key":@"value"} responseCallback:^(id responseData) {
        NSLog(@"hello");
     }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
    } else {
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionNone);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [BaaS handleOpenURLWithUrl:url];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [BaaS handleOpenUniversalLinkWithUserActivity:userActivity];
}
@end
