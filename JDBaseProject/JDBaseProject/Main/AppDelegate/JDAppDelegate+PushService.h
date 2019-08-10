//
//  AppDelegate+PushService.h
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import "JDAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN



@interface JDAppDelegate (PushService)


/**
  share push init
 */
-(void)initSharePush;


- (BOOL)JDMovieOpenURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

+(void)JDSchemeOpenUrlActionWithUrl:(NSURL*)url;


@end

NS_ASSUME_NONNULL_END
