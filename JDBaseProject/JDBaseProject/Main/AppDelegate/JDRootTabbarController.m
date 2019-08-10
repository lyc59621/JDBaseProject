//
//  JDRootTabbarController.m
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDRootTabbarController.h"
#import "JDTabPlusButtonSubclass.h"
#if __has_include("JDToolsModuleHeader.h")
#import "JDToolsModuleHeader.h"
#endif

@interface JDRootTabbarController ()<UITabBarControllerDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *subVCs;

// 记录最后点击的索引
@property (nonatomic, assign) NSInteger lastTapIndex;
@property (nonatomic, strong) UITabBarItem *lastItem;
@property (nonatomic, copy) NSString *lastTitle;
@property (nonatomic, assign) BOOL isLoad;

@end

@implementation JDRootTabbarController

+(instancetype)instanceTab
{
//    [JDTabPlusButtonSubclass registerPlusButton];//中间凸起
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    JDRootTabbarController   *tab =  [JDRootTabbarController tabBarControllerWithViewControllers:[JDRootTabbarController viewControllers] tabBarItemsAttributes:[JDRootTabbarController tabBarItemsAttributesForController] imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment context:nil];
    [tab customizeTabBarAppearance];
    return tab;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
#if __has_include("JDToolsModuleHeader.h")
#if DEBUG
    YYFPSLabel   *fps =  [[YYFPSLabel  alloc]initWithFrame:CGRectMake(kMainScreenWidth-70,kMainScreenHeight-80, 70, 30)];
    [kAppWindow addSubview:fps];
#endif
    
#else
    DDLogVerbose(@"请导入JDToolsModuleHeader.h");
#endif

//    WS(weakSelf)
//    [[kUserManager.subject filter:^BOOL(id  _Nullable value) {
//        return value!=nil?true:false;
//    }] subscribeNext:^(id  _Nullable x) {
//        JDUserObject  *user = (JDUserObject*)x;
//        if([user.settingStatus boolValue]!=true&&!weakSelf.isLoad)
//        {
//            JDCompletionInfoPage *infoVC = [JDCompletionInfoPage nibInstanceWithArguments:@{}];
//            JDBaseNavigationController *navi = [[JDBaseNavigationController alloc] initWithRootViewController:infoVC];
//            [weakSelf presentViewController:navi animated:true completion:nil];
//            weakSelf.isLoad = true;
//        }
//    }];
//    [kUserManager verifyUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appShareAction:) name:KNotificationShareActionKey object:nil];
//
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self selector:@selector(postSelectDateTabAction:) name:KNotificationDateTabSelecttKey object:nil];
//
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self selector:@selector(postSelectLiveTabAction:) name:KNotificationLiveTabSelectKey object:nil];
 
}

+ (NSArray *)viewControllers {
   
    
//    UIViewController *homeVC = [[CTMediator sharedInstance] plazaHome_ViewControllerWithParams:@{}];
//    UIViewController *videoVC = [[CTMediator sharedInstance] videoHomeList_ViewControllerWithParams:@{}];
//    UIViewController *msgVC  = [[CTMediator sharedInstance] message_ViewControllerWithParams:@{}];
//    msgVC.tabBarItem.qmui_updatesIndicatorSize = CGSizeMake(7, 7);
//    msgVC.tabBarItem.qmui_updatesIndicatorColor = [UIColor redColor];
//    msgVC.tabBarItem.qmui_updatesIndicatorCenterOffset = CGPointMake(15, -10);
//    UIViewController   *mineVC = [[CTMediator sharedInstance] mine_JDMineViewPageWithParams:@{}];
//    NSArray *controllers = @[homeVC,videoVC,msgVC,mineVC];
//
////    self.subVCs = controllers;
//    // 创建一个可变数组存放所有的导航控制器
//    NSMutableArray *navCtrls = [[NSMutableArray alloc] init];
//    for (UIViewController *viewCtrl in controllers) {
//        // 创建导航控制器
//        JDBaseNavigationController *baseNavCtrl = [[JDBaseNavigationController alloc] initWithRootViewController:viewCtrl];
//        // 导航控制器添加到数组中
//        [navCtrls addObject:baseNavCtrl];
//    }
//    return navCtrls;
    return @[];
}
+ (NSArray *)tabBarItemsAttributesForController {
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"a_nav_home_nor",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"aNavHomeSel",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)]
                                                 //第一位 右大，下大
                                                 };
    CGFloat secondXOffset = (-25+2)/2;
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"影库",
                                                  CYLTabBarItemImage : @"aNavMovieNor",
                                                  CYLTabBarItemSelectedImage : @"aNavMovieSel",
                                                  CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(secondXOffset, -3.5)]
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"消息",
                                                 CYLTabBarItemImage : @"aNavMassageNor",
                                                 CYLTabBarItemSelectedImage : @"a_nav_massage_sel",
                                                 CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-secondXOffset, -3.5)]
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"aNavPersonNor",
                                                  CYLTabBarItemSelectedImage : @"a_nav_preson_sel",
                                                  CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)]
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}
/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = HEXCOLOR(0x7a767a);
    normalAttrs[NSFontAttributeName] = KJD_FONT_Medium(8);
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = HEXCOLOR(0xbe3f8b);
    selectedAttrs[NSFontAttributeName] = KJD_FONT_Medium(8);
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
//    [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar background image
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[UIImage imageWithColor:RGBA(47,51,53,1) size:CGSizeMake(1, 1)]];
//    [tabBarAppearance setBackgroundColor:RGBA(47,51,53,1)];

    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
    [tabBarAppearance setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
//        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = 40;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:RGBA(47,51,53,0.8)
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)scaleImage:(UIImage *)image {
    CGFloat halfWidth = image.size.width/2;
    CGFloat halfHeight = image.size.height/2;
    UIImage *secondStrechImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth) resizingMode:UIImageResizingModeStretch];
    return secondStrechImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark---------------share-------------------
-(void)appShareAction:(NSNotification*)notif
{
    DDLogVerbose(@"去分享==%@",notif.object);
    NSDictionary *dic = notif.object;
//    [JDShareManager ShareNormalParams:dic ActionResult:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//    }];
}
#pragma mark---------------select tab-------------------

-(void)postSelectLiveTabAction:(NSNotification*)notif
{
    self.selectedIndex = 2;
}
-(void)postSelectDateTabAction:(NSNotification*)notif
{
//    self.selectedIndex = 2;
//    UIViewController *meetingVC = [[CTMediator sharedInstance] appointment_ViewControllerWithParams:@{}];
//    [[JDBaseViewController JDCurrentNaVC] pushViewController:meetingVC animated:true];
}
-(void)dealloc
{
    DDLogVerbose(@"deallloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
