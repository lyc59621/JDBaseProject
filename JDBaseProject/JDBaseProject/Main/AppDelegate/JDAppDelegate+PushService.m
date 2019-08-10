//
//  AppDelegate+PushService.m
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import "JDAppDelegate+PushService.h"
#import "NSString+URLParameters.h"
#import "JDBaseViewController.h"
#import <MobPush/MobPush.h>
#import "JDBaseWebViewPage.h"


//static NSArray *JDOpenUrlHosts = nil;

@implementation JDAppDelegate (PushService)

//static NSArray *JDOpenUrlSchemes() {
//
//    return  [[NSArray alloc] initWithObjects:@"JDmovie",@"webview",@"q",@"q", nil];
//}
static NSArray *JDOpenUrlHosts() {

     return  [[NSArray alloc] initWithObjects:@"movie",@"webview",@"user",@"subject", nil];
}
static NSArray *JDOpenUrlMoviePaths() {//电影
    
    return  [[NSArray alloc] initWithObjects:@"/detail",@"/vault",@"/webview",@"/roomDetail", nil];
}
static NSArray *JDOpenUrlUserPaths() {//用户
    
    return  [[NSArray alloc] initWithObjects:@"/homePage",@"",@"", nil];
}
static NSArray *JDOpenUrlSubjectPaths() {//广场
    
    return  [[NSArray alloc] initWithObjects:@"/topic",@"",@"", nil];
}
//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
//    DDLogVerbose(@"走进来了");
//    return YES;
//}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
//    DDLogVerbose(@"走进来了1");
//    return YES;
//}

-(void)initSharePush
{
//    // 设置推送环境
//#if DEBUG
//    [MobPush setAPNsForProduction:NO];
//#else
//    [MobPush setAPNsForProduction:YES];
//#endif
//    //MobPush推送设置（获得角标、声音、弹框提醒权限）
//    MPushNotificationConfiguration *configuration = [[MPushNotificationConfiguration alloc] init];
//    configuration.types = MPushAuthorizationOptionsBadge | MPushAuthorizationOptionsSound | MPushAuthorizationOptionsAlert;
//    [MobPush setupNotification:configuration];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessage:) name:MobPushDidReceiveMessageNotification object:nil];
//    [MobPush getRegistrationID:^(NSString *registrationID, NSError *error) {
//        NSLog(@"Push---registrationID = %@\nerror = %@", registrationID, error);
//    }];
//    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}
// 收到通知回调
- (void)didReceiveMessage:(NSNotification *)notification
{
    MPushMessage *message = notification.object;
    switch (message.messageType)
    {
            case MPushMessageTypeUDPNotify: {
                
                
            }
            break;
            case MPushMessageTypeCustom: {
                // 自定义消息
            DDLogVerbose(@"收到自定义消息");
            }
            break;
          case MPushMessageTypeAPNs: {
              // APNs 回调
                if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
                    // 前台
                    DDLogVerbose(@"收到前台消息");
                }
                else
                { // 后台
                    DDLogVerbose(@"收到后台消息");
                }
            }
            break;
         case MPushMessageTypeLocal: { // 本地通知回调
            NSString *body = message.notification.body;
            NSString *title = message.notification.title;
            NSString *subtitle = message.notification.subTitle;
            NSInteger badge = message.notification.badge;
            NSString *sound = message.notification.sound;
            DDLogVerbose(@"收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%ld，\nsound：%@，\n}",body, title, subtitle, badge, sound);
            }
            break;
    }
}

#pragma mark-------------------Open URl-------------------------
- (BOOL)JDMovieOpenURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
//    JDmovie://movie/detail?movieId=9bcfd92d-ba52-11e8-a875-6c0b84d5e51c
    DDLogVerbose(@"sourceApplication: %@", options);
    [[self class] JDSchemeOpenUrlActionWithUrl:url];
    return YES;
}
+(void)JDSchemeOpenUrlActionWithUrl:(NSURL*)url
{
    DDLogVerbose(@"URL scheme:%@", [url scheme]);
    DDLogVerbose(@"URL query: %@", [url query]);
    DDLogVerbose(@"URL host: %@", [url host]);
    DDLogVerbose(@"URL path: %@", [url path]);
    NSDictionary  *dic = [[url description] getURLParameters];
    DDLogVerbose(@"参数Dic===%@",dic);
    
    if (![[url scheme] isEqualToString:@"JDmovie"]) {
     
        [[UIApplication sharedApplication]openURL:url];
        return;
    }
    switch ([JDOpenUrlHosts() indexOfObject:[url host]]) {
            case 0: //movie
            [[self class] JDSchemeMovieActionWith:url];
            break;
            case 1: //web
            [[self class] JDSchemeWebViewActionWith:url];
            break;
            case 2: //homepage
            [[self class] JDSchemeHomePageViewActionWith:url];
            break;
    }
}
+(void)JDSchemeMovieActionWith:(NSURL*)url
{
    switch ([JDOpenUrlMoviePaths() indexOfObject:[url path]]) {
        case 0:
        {
           
        }
            break;
    }
}
+(void)JDSchemeWebViewActionWith:(NSURL*)url
{
    NSString  *urlstr = [[url path] substringFromIndex:1];
//    JDBaseWebViewPage  *baseWeb = [JDBaseWebViewPage instanceWithArguments:@{@"url":urlstr}];
//    [[JDBaseViewController JDCurrentNaVC] pushViewController:baseWeb animated:true];
}
+(void)JDSchemeHomePageViewActionWith:(NSURL*)url
{
    switch ([JDOpenUrlUserPaths() indexOfObject:[url path]]) {
        case 0:
        {
            NSDictionary  *dic = [[url description] getURLParameters];
//            UIViewController *homePage = [[CTMediator sharedInstance] mine_HomePageViewControllerWithParams:@{@"userNickname":dic[@"userNickname"]}];
//            [[JDBaseViewController JDCurrentNaVC] pushViewController:homePage animated:true];
        }
            break;
    }
}




@end
