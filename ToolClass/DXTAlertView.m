//
//  DXTAlertView.m
//  QKZhi-iOS
//
//  Created by 技术部 on 17/3/2.
//  Copyright © 2017年 上海钱坤信息科技有限公司. All rights reserved.
//

#import "DXTAlertView.h"

@interface DXTAlertView (){
    UITapGestureRecognizer *tap ;
}




@end

@implementation DXTAlertView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void) setupSubViews {
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [self.keyWindow addSubview:self.bgView];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAlert)];
    [self.bgView addGestureRecognizer:tap];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

- (void)hiddenAlert {
    [self hiddenAlertView];
}

- (void)addKeyborder {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyborderShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyborderHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)showAlertView{
    [self.keyWindow addSubview:self];
    self.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(1.2,1.2);
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        weakSelf.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}

- (void)showAlertViewComplete:(void (^)(void))complate {
    [self.keyWindow addSubview:self];
    self.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(1.2,1.2);
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        weakSelf.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (complate) {
            complate();
        }
    }];
}

- (void) hiddenAlertView {

    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgView.alpha = 0.01;
    }completion:^(BOOL finished) {
        [weakSelf.bgView removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark 键盘监听
- (void) keyborderShow:(NSNotification *)not {
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [not.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //获取键盘frame
    CGRect keybordRect = [[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect rect = CGRectIntersection(keybordRect, self.frame);
    
    __weak typeof(self) weakSelf = self;
    //if (CGRectIntersectsRect(self.frame, keybordRect)) {
        [UIView animateWithDuration:animationDuration animations:^{
            weakSelf.center = CGPointMake(weakSelf.center.x, weakSelf.center.y - (rect.size.height));
        }];
    //}else {
//        [UIView animateWithDuration:animationDuration animations:^{
//            //键盘收起，视图复原
//            weakSelf.frame = CGRectMake(26, [UIScreen mainScreen].bounds.size.height / 2.0 - weakSelf.frame.size.height / 2.0, self.frame.size.width, weakSelf.frame.size.height);
//        }];
        
    //}
}

- (void) keyborderHidden:(NSNotification *)not {
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [not.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //获取键盘frame
    //CGRect keybordRect = [[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
   // CGRect rect = CGRectIntersection(keybordRect, self.frame);
    
    __weak typeof(self) weakSelf = self;
    //if (CGRectIntersectsRect(self.frame, keybordRect)) {
//    [UIView animateWithDuration:animationDuration animations:^{
//        weakSelf.center = CGPointMake(weakSelf.center.x, weakSelf.center.y - (rect.size.height));
//    }];
    //}else {
    [UIView animateWithDuration:animationDuration animations:^{
        //键盘收起，视图复原
        weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, [UIScreen mainScreen].bounds.size.height / 2.0 - weakSelf.frame.size.height / 2.0, weakSelf.frame.size.width, weakSelf.frame.size.height);
    }];
    
    //}

}

/**
 * 去掉背景视图的点击效果
 */
- (void)removeBgViewTapEvent {
    [self.bgView removeGestureRecognizer:tap];
}

- (void)addTimer {
    NSTimer *myTimer = [NSTimer  timerWithTimeInterval:2.0 target:self selector:@selector(timerFired:)userInfo:nil repeats:NO];
    [[NSRunLoop  currentRunLoop] addTimer:myTimer forMode:NSDefaultRunLoopMode];
}

- (void)timerFired:(NSTimer *)timer {
    [self hiddenAlertView];
    [timer invalidate];
}

- (void)setBgViewBackgroundColor:(UIColor *)color{
    self.bgView.backgroundColor = color;
}
- (void)removeBgView {
    [self.bgView removeFromSuperview];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
