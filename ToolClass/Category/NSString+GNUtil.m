//
//  NSString.m
//  MarketEleven
//
//  Created by Bergren Lam on 8/6/14.
//  Copyright (c) 2014 Meinekechina. All rights reserved.
//

#import "NSString+GNUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>

#import "NSDate+Util.h"
#import "UIColor+GNUtil.h"
#define AV_DATE_FORMAT  @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"

@implementation NSString (GNUtil)

+(NSString *)getdate:(NSString *)string{
    if (string.length > 16) {
       return  [string substringToIndex:16];
    }else{
    return string;
    }
}

+(NSString *)getDateString:(NSDate *)date{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm"];
    NSString *str = [formatter stringFromDate:date];
    if ([date isToday]) {
        if (str.length >16) {
            NSString *day = [str substringWithRange:NSMakeRange(11, 5)];
            return [NSString stringWithFormat:@"今日:%@",day];
        }else{
            return str;
        }
    }else{
        if (str.length > 16) {
            return  [str substringToIndex:16];
        }else{
            return str;
        }
    }
    return str;
}

- (BOOL)includeChinese{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

+(NSString *)getStringWithDateFormatter:(NSString *)format date:(NSDate *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+(NSString *)getDateFormatString:(NSDate *)date DateFormat:(NSString *)format{

    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *str = [formatter stringFromDate:date];
    if ([date isToday]) {
        return @"今日:";
    } else {
        return str;
    }
    return str;
}

+ (NSString *)deviceADIdentifier{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font {
    
    CGSize size = CGSizeMake(MAXFLOAT, 0);
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize detailSize = [string boundingRectWithSize:size
                                             options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return detailSize.width;
}

- (NSString *)replaceAllWhiteSpace{
    NSArray *filteredArray2;
    @autoreleasepool {
        
        NSCharacterSet *whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];

        NSArray *parts = [self componentsSeparatedByCharactersInSet:whitespaces];
        
        NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
        
        NSString *theString = [filteredArray componentsJoinedByString:@""];
        
        NSArray *parts2 = [theString componentsSeparatedByCharactersInSet:[NSCharacterSet controlCharacterSet]];
        
        filteredArray2 = [[NSArray alloc] initWithArray:[parts2 filteredArrayUsingPredicate:noEmptyStrings]];
    }
    
    return [filteredArray2 componentsJoinedByString:@""];
}

//检测是否是手机号码
- (BOOL)isMobileNumber{
    if ([self hasPrefix:@"1"] && ![self hasPrefix:@"11"]) {
        
        if (self.length == 11 && [self isPureInt]) {
            return YES;
        }
    }
    return NO;
}

//验证输入是否是数字
- (BOOL) valifyNumber{
    NSString *numberWordRegex = @"^[0-9]+$";
    NSPredicate *numberWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberWordRegex];
    return [numberWordPredicate evaluateWithObject:self];
}

//验证输入是否是数字
- (BOOL) valifyNumberOrZiMuOrXiaHuaXian{
    NSString *numberWordRegex = @"^[0-9a-zA-Z_\u4e00-\u9fa5]+$";
    NSPredicate *numberWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberWordRegex];
    return [numberWordPredicate evaluateWithObject:self];
}

//身份证号

+ (BOOL) validateIdentityCard: (NSString *)identityCard

{
    
    BOOL flag;
    
    if (identityCard.length <= 0) {
        
        flag = NO;
        
        return flag;
        
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    return [identityCardPredicate evaluateWithObject:identityCard];
    
}

//验证输入的是否是字母或者数字
+ (BOOL) ziMuOrNumber:(NSString *)str {
    NSString * regex = @"^[A-Za-z0-9]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/**
 * 判断 字母、数字、中文、下划线
 */
- (BOOL)isInputRuleAndNumber:(NSString *)str
{
    NSString *other = @"➋➌➍➎➏➐➑➒";     //九宫格的输入值
    unsigned long len=str.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[str characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             ||((a=='_') || (a == '-')) //判断是否允许下划线，昵称可能会用上
             ||((a==' '))                 //判断是否允许控制
             ||((a >= 0x4e00 && a <= 0x9fa6))
             ||([other rangeOfString:str].location != NSNotFound)
             ))
            return NO;
    }
    return YES;
}


- (BOOL)isValidatePlateNumber
{
    NSString *carRegex = @"^[/京|津|沪|川|鄂|赣|贵|黑|吉|冀|晋|辽|鲁|云|蒙|苏|浙|皖|闽|豫|湘|粤|桂|琼|渝|陕|甘|青|宁|新|贵|藏/]{1}[A-Za-z0-9]{6}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    
    return [carTest evaluateWithObject:self];
}

- (BOOL)isZhiShuNumber
{
    NSString *zhishuRegex = @"^SH00[0-9]{4}|^SZ39[0-9]{4}";
    NSPredicate *zhishuTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zhishuRegex];
    
    return [zhishuTest evaluateWithObject:self];
}


- (BOOL)isPureFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+(NSString *)setTime:(NSString *)dataStr isflag:(BOOL)flag{
    if (dataStr.length==0) {
        return @"";
    }
    //月
    NSString *monthStr = [dataStr substringWithRange:NSMakeRange(4, 2)];
    //日
    NSString *dayStr = [dataStr substringWithRange:NSMakeRange(6, 2)];
    //年
    NSString *yearStr = [dataStr substringToIndex:4];
//    //时
//    NSString *hourStr = [dataStr substringWithRange:NSMakeRange(8, 2)];
//    //分
//    NSString *minStr = [dataStr substringWithRange:NSMakeRange(10, 2)];
//    if (flag == YES) {
        return [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
//    }
//    else {
//        return [NSString stringWithFormat:@"%@/%@/%@",dayStr,monthStr,yearStr];
//    }
}

+ (CGSize) stringLengthWithStr:(NSString *)str with:(CGFloat)with height:(CGFloat)height font:(CGFloat)font{
    CGSize size = [str boundingRectWithSize:CGSizeMake(with, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size;
}

+ (NSAttributedString *)stringWithCompleteStr:(NSString *)completeStr subStr:(NSArray *)subStrs normolColor:(NSString *)color weightColor:(NSString *)weightColor {
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:completeStr attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:color]}];
    for (NSString *subStr in subStrs) {
        NSRange range = [completeStr rangeOfString:subStr];
        if (range.location != NSNotFound) {
            [tempStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:weightColor]} range:range];
        }
    }
    
    return tempStr;
}

+ (NSAttributedString *)stringWithCompleteStr:(NSString *)completeStr subStr:(NSArray *)subStrs normolColor:(NSString *)color weightColors:(NSArray *)weightColors {
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:completeStr attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:color]}];
    NSInteger index = 0;
    for (NSString *subStr in subStrs) {
        NSRange range = [completeStr rangeOfString:subStr];
        if (range.location != NSNotFound) {
            [tempStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:weightColors[index]]} range:range];
        }
        index ++;
    }
    
    return tempStr;
}

+ (NSAttributedString *)stringWithCompleteStr:(NSString *)completeStr subStr:(NSArray *)subStrs normolColor:(NSString *)color weightColor:(NSString *)weightColor normolFont:(CGFloat)normalFont weightFont:(CGFloat)weightFont{
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:completeStr attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:color],NSFontAttributeName:[UIFont systemFontOfSize:normalFont]}];
    for (NSString *subStr in subStrs) {
        NSRange range = [completeStr rangeOfString:subStr];
        if (range.location != NSNotFound) {
            [tempStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:weightColor],NSFontAttributeName:[UIFont systemFontOfSize:weightFont]} range:range];
        }
    }
    
    return tempStr;
}

-(CGFloat)getStringHeight:(UIFont*)font width:(CGFloat)width{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  font, NSFontAttributeName,
                                  nil];
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, self.length)];
    CGRect stringRect = [attributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       context:nil];
    
    return stringRect.size.height;
}

-(CGFloat)getStringWidth:(UIFont*)font Height:(CGFloat)height{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  font, NSFontAttributeName,
                                  nil];
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, self.length)];
    CGRect stringRect = [attributedString boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                         
                                                       context:nil];
    
    return stringRect.size.width;
}
- (NSString *)CJS_CompareCurrentTime:(NSDate *)timeDate {
    //得到与当前时间差
//    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
//    timeInterval = -timeInterval;
//    long temp = 0;
//    NSString *result;
//    if (timeInterval < 60) {
//        result = [NSString stringWithFormat:@"刚刚"];
//    }
//    else if((temp = timeInterval/60) <60){
//        result = [NSString stringWithFormat:@"%ld分钟前",temp];
//    }
//    else if((temp = temp/60) <24){
//        result = [NSString stringWithFormat:@"%ld小时前",temp];
//    }
//    else if((temp = temp/24) <30){
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//    }
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
//    else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
    return [NSString getStringWithDateFormatter:@"yyyy-MM-dd HH:mm:ss" date:timeDate];
}
- (NSString *)CJS_InfoCompareCurrentTime:(NSDate *)timeDate {
    //得到与当前时间差
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <8){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }else{
        result = [NSString getStringWithDateFormatter:@"yyyy-MM-dd" date:timeDate];
    }
    return result;
}
+(NSString *)countNumAndChangeformat:(double)doubel{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:doubel]];
    return formattedNumberString;
}


/**
 * author: 罗静
 * 获取字符串前几位
 * @return 返回block，该block的返回值为获取的字符串，当没有获取到，返回@""，参数为获取到第几位
 */
- (NSString *(^)(NSInteger))frontPlace {
    return ^NSString *(NSInteger place){
        if (place > self.length) {
            return @"";
        }
        return [self substringWithRange:NSMakeRange(0, place)];
    };
}

+ (BOOL) isNewPhoneNumber:(NSString *)mobileNum{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,199,198,166
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709,199,198,166
     * 电信号段: 133,153,180,181,189,177,1700,199,198,166
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678]|6[0-9]|9[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //   NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(NSString *)dealNumberWithCount:(CGFloat)count{
    
    NSString *cuttentstr = @"0";
    if (count<10000) {
        cuttentstr = [NSString stringWithFormat:@"%d",(int)count];
    }else if (count>=10000&&count<1000000){
         cuttentstr = [NSString stringWithFormat:@"%.2f万",count/10000.0];
    }else{
         cuttentstr = [NSString stringWithFormat:@"%.2f百万",count/1000000.0];
    }
    return cuttentstr;
    
}



@end
