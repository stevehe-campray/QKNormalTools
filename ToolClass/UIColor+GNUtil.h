//
//  UIColor+GNUtil.h
//  MarketEleven
//
//  Created by Bergren Lam on 8/6/14.
//  Copyright (c) 2014 Meinekechina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GNUtil)

+ (UIColor *)randomColor;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;


+ (UIColor *)realBarTintColor:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;
@end
