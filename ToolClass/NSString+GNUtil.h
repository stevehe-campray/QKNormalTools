//
//  NSString.h
//  MarketEleven
//
//  Created by Bergren Lam on 8/6/14.
//  Copyright (c) 2014 Meinekechina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    todayStyle,
    otherStyle,
} dateStringStyle;

@interface NSString (GNUtil)



+ (NSString *) deviceADIdentifier;
+(NSString *)getDateString:(NSDate *)date;
- (NSString *)replaceAllWhiteSpace;
- (BOOL)includeChinese;
- (BOOL)isMobileNumber;
- (BOOL)isValidateEmail;
- (BOOL)isValidatePlateNumber;
- (BOOL)isPureInt;
- (BOOL)isPureFloat;
/**验证当前输入是否是数字*/
- (BOOL)valifyNumber;

+ (BOOL) validateIdentityCard: (NSString *)identityCard;

+ (BOOL) ziMuOrNumber:(NSString *)str;

- (BOOL)isZhiShuNumber;
+(NSString *)getDateFormatString:(NSDate *)date DateFormat:(NSString *)format;
+(NSString *)setTime:(NSString *)dataStr isflag:(BOOL)flag;
/**计算字符串高度*/
+ (CGSize) stringLengthWithStr:(NSString *)str with:(CGFloat)with height:(CGFloat)height font:(CGFloat)font;

+ (NSAttributedString *)stringWithCompleteStr:(NSString *)completeStr subStr:(NSArray *)subStrs normolColor:(NSString *)color weightColor:(NSString *)weightColor;

+ (NSAttributedString *)stringWithCompleteStr:(NSString *)completeStr subStr:(NSArray *)subStrs normolColor:(NSString *)color weightColors:(NSArray *)weightColors;

+(NSString *)getStringWithDateFormatter:(NSString *)format date:(NSDate *)date;
-(CGFloat)getStringHeight:(UIFont*)font width:(CGFloat)width;
-(CGFloat)getStringWidth:(UIFont*)font Height:(CGFloat)height;
- (NSString *)CJS_CompareCurrentTime:(NSDate *)timeDate;
- (NSString *)CJS_InfoCompareCurrentTime:(NSDate *)timeDate ;
+(NSString *)countNumAndChangeformat:(double)doubel;

+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;
/*!
 @brief 获取字符串前几位
 @return 返回block，该block的返回值为获取的字符串，当没有获取到，返回@""，参数为获取到第几位
 */
- (NSString *(^)(NSInteger))frontPlace;

+ (NSString *)dealNumberWithCount:(CGFloat)count;

- (BOOL) valifyNumberOrZiMuOrXiaHuaXian;

- (BOOL)isInputRuleAndNumber:(NSString *)str;

+ (BOOL) isNewPhoneNumber:(NSString *)mobileNum;

+ (NSAttributedString *)stringWithCompleteStr:(NSString *)completeStr subStr:(NSArray *)subStrs normolColor:(NSString *)color weightColor:(NSString *)weightColor normolFont:(CGFloat)normalFont weightFont:(CGFloat)weightFont;

@end
