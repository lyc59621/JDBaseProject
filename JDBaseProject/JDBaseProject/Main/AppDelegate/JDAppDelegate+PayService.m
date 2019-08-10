//
//  AppDelegate+PayService.m
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import "JDAppDelegate+PayService.h"
//#import <ICPaySDK.h>
#import "JDAppDelegate+PushService.h"

@implementation JDAppDelegate (PayService)



-(void)payServiceAction
{
    
//    [[ICPayDesignManager shareInstance]
//     registerSDKWithDictionary:@{ICWxPayChannelKey : @"wxab7033bb3bce16bc"}];
}
#pragma mark ————— OpenURL 回调 —————
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
//    return [[ICPayDesignManager shareInstance] handleOpenURL:url sourceApplication:sourceApplication];
//
//}


// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    if ([url.scheme isEqualToString:@"JDmovie"]) {
        
         return   [self JDMovieOpenURL:url options:options];
    }else
    {
//        return [[ICPayDesignManager shareInstance] handleOpenURL:url sourceApplication:nil];
        return YES;

    }
}
@end
