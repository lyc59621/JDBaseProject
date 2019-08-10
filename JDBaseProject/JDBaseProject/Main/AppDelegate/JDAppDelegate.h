//
//  AppDelegate.h
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDBaseAppDelegate.h"
#import "JDRootTabbarController.h"

@interface JDAppDelegate : JDBaseAppDelegate



/**
 RootTabbarController
 */
@property (strong, nonatomic) JDRootTabbarController *mainTabBar;
/**
 网络监听
 */
@property (strong, nonatomic) YYReachability *yyReach;



@end

