

//
//  UIFont+CAPJuageFont.m
//  Capacap
//
//  Created by hejingjin on 2017/11/28.
//  Copyright © 2017年 kingyon. All rights reserved.
//

#import "UIFont+CAPJuageFont.h"
#import "QKNormalTools.h"
// 这里设置iPhone6放大的字号数（现在是放大2号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为17）
#define IPHONE5_INCREMENT 2

// 这里设置iPhone6Plus放大的字号数（现在是放大3号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为18）
#define IPHONE6PLUS_INCREMENT 1
@implementation UIFont (CAPJuageFont)

+(void)load{
    
    //获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    //获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    //然后交换类方法
    method_exchangeImplementations(newMethod, method);
    
    //获取替换后的类方法
    Method newMethod1 = class_getClassMethod([self class], @selector(adjustFontWithName:Size:));
    //获取替换前的类方法
    Method method1 = class_getClassMethod([self class], @selector(fontWithName:size:));
    //然后交换类方法
    method_exchangeImplementations(newMethod1, method1);
    
    //获取替换后的类方法
    Method newMethod2 = class_getClassMethod([self class], @selector(adjustFontOfSize:weight:));
    //获取替换前的类方法
    Method method2 = class_getClassMethod([self class], @selector(systemFontOfSize:weight:));
    //然后交换类方法
    method_exchangeImplementations(newMethod2, method2);
}

+(UIFont *)adjustFont:(CGFloat)fontSize{
    UIFont *newFont=nil;
    if (IsIphone5S){
        newFont = [UIFont adjustFont:fontSize - IPHONE5_INCREMENT];
    }else if (IsIphone6P){
        newFont = [UIFont adjustFont:fontSize + IPHONE6PLUS_INCREMENT];
    }else{
        newFont = [UIFont adjustFont:fontSize];
    }
    return newFont;
}

+(UIFont *)adjustFontWithName:(NSString *)name Size:(CGFloat) size{
    UIFont *newFont=nil;
    if (IsIphone5S){
        newFont = [UIFont adjustFontWithName:name Size:size - IPHONE5_INCREMENT];
    }else if (IsIphone6P){
        newFont = [UIFont adjustFontWithName:name Size:size + IPHONE6PLUS_INCREMENT];
    }else{
        newFont = [UIFont adjustFontWithName:name Size:size];
    }
    return newFont;
}

+ (UIFont *)adjustFontOfSize:(CGFloat) size weight:(UIFontWeight)weight {
    UIFont *newFont=nil;
    if (IsIphone5S){
        newFont = [UIFont adjustFontOfSize:size - IPHONE5_INCREMENT weight:weight];
    }else if (IsIphone6P){
        newFont = [UIFont adjustFontOfSize:size + IPHONE6PLUS_INCREMENT weight:weight];
    }else{
        newFont = [UIFont adjustFontOfSize:size weight:weight];
    }
    return newFont;
}
@end
