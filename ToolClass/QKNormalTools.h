//
//  QKNormalTools.h
//  QKNormalTools
//
//  Created by hejingjin on 2018/7/12.
//  Copyright © 2018年 qktools. All rights reserved.
//

#ifndef QKNormalTools_h
#define QKNormalTools_h


#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define ISIphoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//(kStatusBarHeight == 20.f?NO:YES)

#define KScreenSize [UIScreen mainScreen].bounds.size
#define IsIphone6P KScreenSize.width==414
#define IsIphone6 KScreenSize.width==375
#define IsIphone5S KScreenSize.width==320

#define RateselecetDefultColor [UIColor colorWithHexString:@"E0210E"]
#ifdef DEBUG

#define CLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else

#define LKLog( s, ... )

#endif

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define APPDELEGATE           ((AppDelegate *)[[UIApplication sharedApplication] delegate])
/**
 *  相对iphone6 屏幕比
 */
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
#define KHEIGHT_Scale   (ISIphoneX ? 1.0: [UIScreen mainScreen].bounds.size.height/667.0f)

//#define TABBAR_HEIGHT  49
#define NAV_HEIGHT  (ISIphoneX ? 88:64)

#define NOSTATUS_BAR_HEIGHT (ISIphoneX ? 44.f : 0.f)


// 状态栏高度
#define STATUS_BAR_HEIGHT (ISIphoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (ISIphoneX ? 88.f : 64.f)
// tabBar高度
#define TABBAR_HEIGHT (ISIphoneX ? (49.f+34.f) : 49.f)

// 安全域底部高度
#define bottom_HEIGHT (ISIphoneX ? 34.f : 0.f)
/// 高度系数 812.0 是iPhoneX的高度尺寸，667.0表示是iPhone 8 的高度，如果你觉的它会变化，那我也很无奈

#define SafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)
/// 底部宏，
#define SafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : 0)

#define NAVBAR_CHANGE_POINT 50


#define KeyWindows             [UIApplication sharedApplication].keyWindow
#define WeakSelf(weakSelf)      __weak __typeof(&*self)weakSelf = self;

#import "NSDate+Util.h"
#import "UIColor+GNUtil.h"
#import "NSLayoutConstraint+Sws.h"
#import "UIButton+CAPAdjustFont.h"
#import "UIFont+CAPJuageFont.h"
#import "UILabel+CAPAdjustFont.h"
#import "UITextField+CAPAdJustFont.h"
#import "NSDate+QKZCategory.h"
#import "NSDate+Util.h"
#import "NSString+GNUtil.h"
#import "UIColor+GNUtil.h"
#import "UIImage+Color.h"
#import "UINavigationBar+Awesome.h"
#import "UIView+BSTExtention.h"
#import "DXTAlertView.h"


#endif /* QKNormalTools_h */
