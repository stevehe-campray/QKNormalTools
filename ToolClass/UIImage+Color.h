//
//  UIImage+Color.h
//  QKZhi-iOS
//
//  Created by lk on 16/7/15.
//  Copyright © 2016年 cn.com.qktz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+(UIImage *) imageWithColor : (UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+(UIImage *)CL_getSubImage:(UIImage *)originalImage;
@end
