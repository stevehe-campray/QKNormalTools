//
//  UIFont+CAPJuageFont.h
//  Capacap
//
//  Created by hejingjin on 2017/11/28.
//  Copyright © 2017年 kingyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UIFont (CAPJuageFont)
+(UIFont *)adjustFont:(CGFloat)fontSize;

+(UIFont *)adjustFontWithName:(NSString *)name Size:(CGFloat) size;

@end
