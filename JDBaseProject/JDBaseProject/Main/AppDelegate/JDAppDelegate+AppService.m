//
//  AppDelegate+AppService.m
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//


#import "JDAppDelegate+AppService.h"

#if __has_include("JDBaseModuleHeader.h")
#import "JDBaseModuleHeader.h"
#endif
#if __has_include("JDToolsModuleHeader.h")
#import "JDToolsModuleHeader.h"
#endif

#import <Bugly/Bugly.h>

//////   share
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDK/ShareSDK+Base.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//#import "WeiboSDK.h"
//#import "WXApi.h"
//#import "WXApiObject.h"
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>

#import "JDAppDelegate+ADService.h"


/////   UM
#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMAnalytics/MobClick.h>        // 统计组件

#if __has_include(<Hyphenate/Hyphenate.h>)
#import <Hyphenate/Hyphenate.h>
#endif



@implementation JDAppDelegate (AppService)



+ (JDAppDelegate *)shareAppDelegate{
    
    return (JDAppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = HEXCOLOR(0xffffff);
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

#pragma mark ————— 初始化网络配置 —————
-(void)NetWorkConfig{
#if __has_include("JDNetApiManager")
    [JDNetApiManager configNetwork];
#else
    NSAssert(NO, @"请导入JDNetApiManager");
#endif
}

#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
//    KPostNotification(KNotificationLoginStateChange, kGetUserId!=nil?@YES:@NO);
    if (kGetUserAuthToken) {
        self.mainTabBar = [JDRootTabbarController instanceTab];
        [self.window setRootViewController:self.mainTabBar] ;
        [kUserManager loadUserInfo]; //拉取缓存数据
        //初始化AD Image
        [self setADLaunchImageAction];
        [self loginEMChatAction];
    }else
    {
//        UIViewController *login = [[CTMediator sharedInstance] login_ViewControllerWithParams:@{}];
//        UINavigationController  *loginNa = [[JDBaseNavigationController alloc]initWithRootViewController:login];
//        self.window.rootViewController = loginNa;
    }
}
-(void)initTostMeesageHUDManager
{
    

}

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    [self EMLoginStateChangeWithIsLogin:loginSuccess];
    if (loginSuccess) {//登陆成功加载主窗口控制器
        
//        [self registEaseMob];
        //为避免自动登录成功刷新tabbar
        if (self.mainTabBar==nil || ![self.window.rootViewController isKindOfClass:[CYLTabBarController class]]) {
            [self initWindow];
            self.mainTabBar = [JDRootTabbarController instanceTab];
            self.window.rootViewController = self.mainTabBar;
            [self.window makeKeyAndVisible];

        }
    }else {//登陆失败加载登陆页面控制器
//        [kUserManager logout:^(BOOL success, NSString *des) {
//
//            
//        }];
        self.mainTabBar = nil;
//        UIViewController *loginVC = [[CTMediator sharedInstance] login_ViewControllerWithParams:@{}];
//        JDBaseNavigationController *loginNavi =[[JDBaseNavigationController alloc] initWithRootViewController:loginVC];
//        [self initWindow];
//        self.window.rootViewController = loginNavi;
//        [self.window makeKeyAndVisible];
    }
    //展示FPS
    //[AppManager showFPS];
}
-(void)EMLoginStateChangeWithIsLogin:(BOOL)isLogin
{
    if (isLogin) {
        
        [self loginEMChatAction];
    }else
    {
#if __has_include(<Hyphenate/Hyphenate.h>)
        [[EMClient sharedClient] logout:true];
        DDLogVerbose(@"环信退出登录");

#else
        DDLogVerbose(@"请导入Hyphenate");
#endif

    }
    DDLogVerbose(@"环信登录状态改变");
}
-(void)loginEMChatAction
{
    #if __has_include(<Hyphenate/Hyphenate.h>)

        if (![EMClient sharedClient].isLoggedIn) {
            JDUserObject  *user = kCurrentUser;
            NSLog(@"user===%@",user.chatUserId);
            NSLog(@"posw===%@",user.chatUserPwd);
            EMError  * error = [[EMClient sharedClient] loginWithUsername:user.chatUserId password:user.chatUserPwd];
            if (!error) {
                DDLogVerbose(@"环信登录成功");
                NSArray *array = [UIApplication sharedApplication].cyl_tabBarController.viewControllers;
                UIViewController *msgVC = [array objectAtIndex:3];
                msgVC.tabBarItem.qmui_updatesIndicatorSize = CGSizeMake(7, 7);
                msgVC.tabBarItem.qmui_updatesIndicatorColor = [UIColor redColor];
                msgVC.tabBarItem.qmui_updatesIndicatorCenterOffset = CGPointMake(15, -10);
                // 获取未读消息数量
                NSInteger unreadMessageCount = 0;
                NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
                for (EMConversation *conversation in conversations) {
                    if (conversation.type == EMConversationTypeChat) {
                        unreadMessageCount += conversation.unreadMessagesCount;
                    }
                    if (unreadMessageCount > 0) {
                        break;
                    }
                }
                
                if (unreadMessageCount > 0) {
                    msgVC.tabBarItem.qmui_shouldShowUpdatesIndicator = true;
                } else {
                    msgVC.tabBarItem.qmui_shouldShowUpdatesIndicator = false;
                }
                
            }
        }else
        {
            DDLogVerbose(@"环信已经自动登录成功");
            NSArray *array = [UIApplication sharedApplication].cyl_tabBarController.viewControllers;
            UIViewController *msgVC = [array objectAtIndex:3];
            msgVC.tabBarItem.qmui_updatesIndicatorSize = CGSizeMake(7, 7);
            msgVC.tabBarItem.qmui_updatesIndicatorColor = [UIColor redColor];
            msgVC.tabBarItem.qmui_updatesIndicatorCenterOffset = CGPointMake(15, -10);
            // 获取未读消息数量
            NSInteger unreadMessageCount = 0;
            NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
            for (EMConversation *conversation in conversations) {
                if (conversation.type == EMConversationTypeChat) {
                    unreadMessageCount += conversation.unreadMessagesCount;
                }
                if (unreadMessageCount > 0) {
                    break;
                }
            }
            if (unreadMessageCount > 0) {
                msgVC.tabBarItem.qmui_shouldShowUpdatesIndicator = true;
            } else {
                msgVC.tabBarItem.qmui_shouldShowUpdatesIndicator = false;
            }
        }
    #else
    DDLogVerbose(@"请导入Hyphenate");
    #endif
}
#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification
{
//    NSInteger isNetWork = [notification.object integerValue];
//    if (isNetWork) {//有网络
//        if ([userManager loadUserInfo] && !isLogin) {//有用户数据 并且 未登录成功 重新来一次自动登录
//            [userManager autoLoginToServer:^(BOOL success, NSString *des) {
//                if (success) {
//                    DLog(@"网络改变后，自动登录成功");
//                    [TSMessage showSuccessMessageWithMsg:@"网络改变后，自动登录成功"];

//                    KPostNotification(KNotificationAutoLoginSuccess, nil);
//                }else{
//                   [TSMessage showErrorMessageWithMsg:NSStringFormat(@"自动登录失败：%@",des)];
//                }
//            }];
//        }
//
//    }else {//登陆失败加载登陆页面控制器
//        [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
//    }
//    [MBProgressHUD hideHUD];
    NSInteger isNetWork = [notification.object integerValue];
    switch (isNetWork) {
        case 0:
//            [MBProgressHUD showTipMessageInView:@"请检查网络连接"];
            break;
        default:
//            [MBProgressHUD showTipMessageInView:@"网络连接已经恢复"];
            break;
    }
}

#pragma mark ————— mob share 初始化 —————
-(void)initMobSharePlatforms{
   
    
#if __has_include(<ShareSDK/ShareSDK.h>)
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //QQ
        [platformsRegister setupQQWithAppId:@"101502099" appkey:@"e0ae5627829b5d1538f337abe2cc4e92"];
        
        //微信
        [platformsRegister setupWeChatWithAppId:@"wxab7033bb3bce16bc" appSecret:@"b9486baa17aca0e6fb6c220d78a0dd9f"];
        
        //新浪
        [platformsRegister setupSinaWeiboWithAppkey:@"2740695684" appSecret:@"a27ce43bca85832c4992dabdd865072f" redirectUrl:@"https://app.JDmovie.com/api/oauth2/weibo/callback"];
    }];
#endif
    
}
#pragma mark ————— 友盟 初始化 —————
-(void)initUMeng{
    /* 打开调试日志 */ //开发调试时可在console查看友盟日志显示，发布产品必须移除。
    [UMConfigure setLogEnabled:YES];
//    /* 设置友盟appkey */
    [UMConfigure initWithAppkey:@"5c9f1bc861f5644fc1000a0c" channel:@"App Store"];
    [self configUSharePlatforms];
}
#pragma mark ————— 配置第三方 —————
-(void)configUSharePlatforms{
    
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    
}


#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{    
    //监听网络变化
    self.yyReach =  [YYReachability reachabilityWithHostname:kURL_Reachability_Address];
    self.yyReach.notifyBlock = ^(YYReachability * _Nonnull reachability) {

        switch (reachability.status) {
            case 0:
                KPostNotification(KNotificationNetWorkStateChange, @0);
                break;
            case 1:
                KPostNotification(KNotificationNetWorkStateChange, @1);
                break;
            case 2:
                DDLogVerbose(@"wifi");
                KPostNotification(KNotificationNetWorkStateChange, @2);
                break;
            default:
                break;
        }
    };
}

#pragma mark ————— 全局Log设置 —————
-(void)initDDLogManager
{
#if __has_include("JDToolsModuleHeader.h")
   [JDLoggerManager sharedManager];
#else
    NSAssert(NO, @"请导入JDToolsModuleHeader.h");
#endif
}

#pragma mark —————SafeCarch and Buuly  —————
-(void)initSafeCarchAndBugly
{
//    [Bugly startWithAppId:KBuglyID];

#if __has_include("JDToolsModuleHeader.h")
    //开启防止闪退功能
    [LSSafeProtector openSafeProtectorWithIsDebug:YES block:^(NSException *exception, LSSafeProtectorCrashType crashType) {
        //[Bugly reportException:exception];
        //此方法相对于上面的方法，好处在于bugly后台查看bug崩溃位置时，不用点击跟踪数据，再点击crash_attach.log，查看里面的额外信息来查看崩溃位置
        //开启Bugly
        //    [Bugly reportExceptionWithCategory:3 name:exception.name reason:[NSString stringWithFormat:@"%@  崩溃位置:%@",exception.reason,exception.userInfo[@"location"]] callStack:@[exception.userInfo[@"callStackSymbols"]] extraInfo:exception.userInfo terminateApp:NO];
    }];
    DLog(@"设备IMEI ：%@",[OpenUDID value]);
#else
    NSAssert(NO, @"请导入JDToolsModuleHeader.h");
#endif
   
    [self configBuglyHotFix];
    
}

/**
   配置buglyHotFix
 */
- (void)configBuglyHotFix {
    

}
+(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


-(void)pushLogin
{
//    UIViewController *loginVC = [[CTMediator sharedInstance] login_ViewControllerWithParams:@{}];
//    JDBaseNavigationController *navi = [[JDBaseNavigationController alloc] initWithRootViewController:loginVC];
//    [[JDBaseViewController JDCurrentUiVC] presentViewController:navi animated:YES completion:nil];
}


@end
