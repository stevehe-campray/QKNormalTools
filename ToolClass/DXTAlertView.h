//
//  DXTAlertView.h
//  QKZhi-iOS
//
//  Created by 技术部 on 17/3/2.
//  Copyright © 2017年 上海钱坤信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DXTAlertView : UIView

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIWindow *keyWindow;

- (void) addKeyborder;

- (void)showAlertView;

- (void) hiddenAlertView;

- (void) removeBgViewTapEvent;

- (void) removeBgView;

- (void)showAlertViewComplete:(void(^)(void))complate;

- (void) addTimer;

- (void)setBgViewBackgroundColor:(UIColor *)color;

- (void)hiddenAlert;


@end
