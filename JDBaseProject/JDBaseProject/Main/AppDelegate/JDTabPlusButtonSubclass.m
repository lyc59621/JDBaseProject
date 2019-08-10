//
//  JDTabPlusButtonSubclass.m
//  JDBaseProject
//
//  Created by 姜锦龙 on 2019/8/10.
//  Copyright © 2019 姜锦龙. All rights reserved.
//

#import "JDTabPlusButtonSubclass.h"
#import "CYLTabBarController.h"

@interface JDTabPlusButtonSubclass () {
    CGFloat _buttonImageHeight;
}

@end
@implementation JDTabPlusButtonSubclass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
//请在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中进行注册，否则iOS10系统下存在Crash风险。
//[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 1;
//    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 1;
    CGFloat const imageViewEdgeHeight  = self.imageView.bounds.size.height;

    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;

    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5-7;
    CGFloat const centerOfTitleLabel =    + labelLineHeight * 0.5 ;

    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);

    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
    CGRect  ff = self.titleLabel.frame;
    ff.origin.y = self.bounds.size.height-6.5-labelLineHeight;
    self.titleLabel.frame = ff;
    
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    JDTabPlusButtonSubclass *button = [[JDTabPlusButtonSubclass alloc] init];
    
    //    QMUIButton  *button = [QMUIButton  buttonWithType:UIButtonTypeCustom];
    
    UIImage *normalButtonImage = [UIImage imageNamed:@"sNavWatch"];
    UIImage *hlightButtonImage = [UIImage imageNamed:@"sNavWatch"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
    [button setImage:hlightButtonImage forState:UIControlStateSelected];
//    UIImage *normalButtonBackImage = [UIImage imageNamed:@"videoback"];
//    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateNormal];
//    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateSelected];
    button.frame = CGRectMake(0.0, 0, 50, 48+14);
//    button.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
    button.titleLabel.font = KJD_FONT_Medium(8);
    //    [button.titleLabel sizeToFit];
    //    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    [button setTitle:@"中间" forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0x7a767a) forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0xbe3f8b) forState:UIControlStateSelected];

    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %@", @(buttonIndex));
}

#pragma mark - CYLPlusButtonSubclassing

+ (UIViewController *)plusChildViewController {
    
    UIViewController  *vc =[UIViewController new];
    vc.title = @"你管我";
    return vc;
}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}
+ (BOOL)shouldSelectPlusChildViewController {
    BOOL isSelected = CYLExternPlusButton.selected;
    if (isSelected) {
        //        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
    } else {
        //        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
    }
    return YES;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+(CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - 6 : 4);
}

//+ (NSString *)tabBarContext {
//    return NSStringFromClass([self class]);
//}
@end
