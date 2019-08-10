//
//  AppDelegate+AppService.h
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import "JDAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

/**
 包含第三方 和 应用内业务的实现，减轻入口代码压力
 */
@interface JDAppDelegate (AppService)



/**
 初始化服务
 */
-(void)initService;


/**
 初始化 window
 */
-(void)initWindow;

/**
 初始化 Share
 */
-(void)initMobSharePlatforms;
/**
 初始化 UMeng
 */
-(void)initUMeng;

//初始化用户系统

/**
 初始化用户系统
 */
-(void)initUserManager;


/**
 监听网络状态
 */
- (void)monitorNetworkStatus;


/**
 初始化网络配置
 */
-(void)NetWorkConfig;


/**
 初始化Log
 */
-(void)initDDLogManager;


/**
 防闪退及bug上传
 */
-(void)initSafeCarchAndBugly;

//单例

/**
 AppDelegate单例

 @return AppDelegate
 */
+ (JDAppDelegate *)shareAppDelegate;


-(void)pushLogin;


@end

NS_ASSUME_NONNULL_END
