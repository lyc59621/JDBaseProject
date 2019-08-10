//
//  AppDelegate.m
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import "JDAppDelegate.h"
#import "JDAppDelegate+AppService.h"
#import "JDAppDelegate+PayService.h"
#import "JDAppDelegate+PushService.h"


@interface JDAppDelegate ()

@end

@implementation JDAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化DDLog
    [self initDDLogManager];
    
    //初始化safe carch and Bugly
    [self initSafeCarchAndBugly];

    //初始化UMeng
    [self initUMeng];
    
    //初始化window
    [self initWindow];
    
    //初始化app服务
    [self initService];
    
    //初始化网络请求配置
    [self NetWorkConfig];
    
    //初始化环信聊天
//    [self initIMChatManager];
    
    //初始化用户系统
    [self initUserManager];
    
    //网络监听
    [self monitorNetworkStatus];
    
    //mob share
    [self initMobSharePlatforms];
    
    [self initSharePush];

    //pay server
    [self payServiceAction];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [MBProgressHUD hideHUD];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
