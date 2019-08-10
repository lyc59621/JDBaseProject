//
//  AppDelegate+ADService.m
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import "JDAppDelegate+ADService.h"
#import "JDAppDelegate+PushService.h"


//#import "LBLaunchImageAdView.h"
//#import "NSObject+LBLaunchImage.h"
//#import "XHLaunchAd.h"

@interface JDLaunchADModel : NSObject

//"id": 14,
//"title": "Ronald Lopez",
//"imgUrl": "https://dev.JDmovie.com/static/test/imgs/1.jpg",
//"contentType": "movie",
//"actionContent": "tzdgxwuj-gvkk-duyi-ptbi-otmuwugwlrjp",
//"subtitle": "包行观多"

@property(nonatomic,copy) NSString  *ID;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *subtitle;
@property(nonatomic,copy) NSString  *imgUrl;
@property(nonatomic,copy) NSString  *contentType;
@property(nonatomic,copy) NSString  *actionContent;
@property(nonatomic,copy) NSString  *videoUrl;
@property(nonatomic,copy) NSString  *resourceType;//1为video，该情况下使用videoUrl进行展示，2为photo，该情况下使用imgUrl进行展示


@end
@implementation JDLaunchADModel

@end;


@implementation JDAppDelegate (ADService)
/*
-(void)setADLaunchImageAction
{
    __weak typeof(self) weakSelf = self;
//    [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
//        self.mainTabBar.view.hidden = true;
//        //设置广告的类型
//        imgAdView.getLBlaunchImageAdViewType(FullScreenAdType);
//        [JDRequest startRequestWithUrl:URL_LaunchAD withExtendArguments:@{@"code":@"splash"} withCompletionBlockWithSuccess:^(JDRequest * _Nonnull request) {
//            NSArray  *arr = request.filtResponseObj[@"adContents"];
//            if (arr.count>0) {
//
//                JDLaunchADModel  *adModel = [JDLaunchADModel modelWithDictionary:arr[0]];
//                [weakSelf setLaunchStartWithAdModel:adModel withADView:imgAdView];
//            }else
//            {
//                self.mainTabBar.view.hidden = false;
//                [imgAdView closeADView];
//            }
//            DDLogVerbose(@"AD===%@",request.filtResponseObj);
//        } failure:^(JDRequest * _Nonnull request) {
//            self.mainTabBar.view.hidden = false;
//            [imgAdView closeADView];
//        }];
//    }];
//    
//    return;
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchScreen];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:6];
    [JDRequest startRequestWithUrl:URL_LaunchAD withExtendArguments:@{@"code":@"splash"} withCompletionBlockWithSuccess:^(JDRequest * _Nonnull request) {
            NSArray  *arr = request.filtResponseObj[@"adContents"];
            if (arr.count>0) {

                JDLaunchADModel  *adModel = [JDLaunchADModel modelWithDictionary:arr[0]];
                if ([adModel.resourceType integerValue]==1) {
                    
                    [weakSelf setLaunchAdVideoStartWithAdModel:adModel];
                }else
                {
                    [weakSelf setLaunchStartWithAdModel:adModel];
                }
            }else
            {
                self.mainTabBar.view.hidden = false;
                [XHLaunchAd removeAndAnimated:false];
            }
            DDLogVerbose(@"AD===%@",request.filtResponseObj);
        } failure:^(JDRequest * _Nonnull request) {
            self.mainTabBar.view.hidden = false;
            [XHLaunchAd removeAndAnimated:false];
        }];
}
-(void)setLaunchStartWithAdModel:(JDLaunchADModel*)model
{
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height );
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = model.imgUrl;
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //缓存机制(仅对网络图片有效)
    //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
    imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFit;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = model;
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    
    //图片已缓存 - 显示一个 "已预载" 视图 (可选)
    if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.imgUrl]]){
        //设置要添加的自定义视图(可选)
//        imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
    }
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

-(void)setLaunchAdVideoStartWithAdModel:(JDLaunchADModel*)model
{
    //广告数据转模型
    
    //配置广告数据
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = 20;
    
    CGFloat  yy =  IS_IPHONEX?5:0;
    
    //广告frame
    videoAdconfiguration.frame = CGRectMake(0, yy, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-yy);
    //广告视频URLString/或本地视频名(请带上后缀)
    //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
    videoAdconfiguration.videoNameOrURLString = model.videoUrl;
    //是否关闭音频
    videoAdconfiguration.muted = NO;
    //视频缩放模式
//    videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspect;

    //是否只循环播放一次
    videoAdconfiguration.videoCycleOnce = YES;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel = model;
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = SkipTypeTimeText;
    //视频已缓存 - 显示一个 "已预载" 视图 (可选)
    if([XHLaunchAd checkVideoInCacheWithURL:[NSURL URLWithString:model.videoUrl]]){
        //设置要添加的自定义视图(可选)
//        videoAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
    }
    
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}


//跳过按钮点击事件
-(void)skipAction{
    
    //移除广告
    [XHLaunchAd removeAndAnimated:YES];
}
 
 
**/


#pragma mark - XHLaunchAd delegate - 倒计时回调
/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
/*
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration{
    //设置自定义跳过按钮时间
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    
    //设置时间
    [button setTitle:[NSString stringWithFormat:@"自定义%lds",duration] forState:UIControlStateNormal];
}
**/
#pragma mark - XHLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
/*
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(JDLaunchADModel*)openModel clickPoint:(CGPoint)clickPoint{
    
    NSLog(@"广告点击事件");
    
    // openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel)
    if(openModel==nil) return;
    [[self class] JDSchemeOpenUrlActionWithUrl:K_URL(openModel.actionContent)];
   
    
}

-(NSArray<UIView *> *)launchAdSubViews_alreadyView{
    
    CGFloat y = XH_FULLSCREEN ? 46:22;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, y, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

#pragma mark - LBLaunchImageAdView---

-(void)setLaunchStartWithAdModel:(JDLaunchADModel*)model withADView:(LBLaunchImageAdView*)imgAdView
{
    imgAdView.adTime = 3;
//    imgAdView.imgUrl = @"http://img1.126.net/channel6/2015/020002/2.jpg?dpi=6401136";
    imgAdView.imgUrl = model.imgUrl;
    imgAdView.clickBlock = ^(clickType type){
        self.mainTabBar.view.hidden = false;
        switch (type) {
                case clickAdType:{
                    NSLog(@"点击广告回调");
//                    [[self class] JDSchemeOpenUrlActionWithUrl:K_URL(@"https://www.JDmovie.com/index.html")];
//                    [[self class] JDSchemeOpenUrlActionWithUrl:K_URL(@"JDmovie://movie/detail?movieId=9bcfd92d-ba52-11e8-a875-6c0b84d5e51c")];
//                    [[self class] JDSchemeOpenUrlActionWithUrl:K_URL(@"JDmovie://webview/www.JDmovie.com/index.html")];
                       [[self class] JDSchemeOpenUrlActionWithUrl:K_URL(model.actionContent)];
                }
                break;
                case skipAdType:
                NSLog(@"点击跳过回调");
                break;
                case overtimeAdType:
                NSLog(@"倒计时完成后的回调");
                break;
        }
    };
}
**/

@end
