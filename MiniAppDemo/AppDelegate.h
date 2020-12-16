//
//  AppDelegate.h
//  MiniAppDemo
//
//  Created by quanhua on 2020/10/29.
//

#import <UIKit/UIKit.h>
@import MinCloud;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DFNavigationController *navigationController;

+ (AppDelegate *)sharedInstance;

@end

