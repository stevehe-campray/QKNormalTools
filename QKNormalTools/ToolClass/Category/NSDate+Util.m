//
//  NSDate+Util.m
//  PropertyTrade
//
//  Created by hejingjin on 15/10/26.
//  Copyright (c) 2015年 All rights reserved.
//

#import "NSDate+Util.h"
#import "NSDate+QKZCategory.h"
#define AV_DATE_FORMAT  @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
@implementation NSDate (Util)


+ (int)compareDateWithFirstDate:(NSDate *)datea SecondDate:(NSDate *)dateb{
    
    NSComparisonResult result = [datea compare:dateb];
    
    NSLog(@"date1 : %@, date2 : %@" ,datea, dateb);
    
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    
    //NSLog(@"Both dates are the same");
    return 0;
    
}


- (NSUInteger)day {
    return [NSDate day:self];
}

- (NSUInteger)month {
    return [NSDate month:self];
}

- (NSUInteger)year {
    return [NSDate year:self];
}

- (NSUInteger)hour {
    return [NSDate hour:self];
}

- (NSUInteger)minute {
    return [NSDate minute:self];
}

- (NSUInteger)second {
    return [NSDate second:self];
}

+ (NSUInteger)day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)daysInYear {
    return [NSDate daysInYear:self];
}

+ (NSUInteger)daysInYear:(NSDate *)date {
    return [self isLeapYear:date] ? 366 : 365;
}


- (int)compareDateWithFirstDate:(NSString *)timeStr SecondDate:(NSString *)secondTimeStr Formatter:(NSString *)formatter{
    
    NSDateFormatter *dateFormatter = [self getStandardChineseTimeFormatter:formatter];
    
    
    NSDate *dateA = [dateFormatter dateFromString:timeStr];
    
    NSDate *dateB = [dateFormatter dateFromString:secondTimeStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    NSLog(@"date1 : %@, date2 : %@" ,dateA, dateB);
    
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    
    //NSLog(@"Both dates are the same");
    return 0;
}

//取得标准的北京时间formatter

- (NSDateFormatter *)getStandardChineseTimeFormatter:(NSString *)formatterStyle{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //设置格式
    formatter.dateFormat = formatterStyle;
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return formatter;
}


- (BOOL)isLeapYear {
    return [NSDate isLeapYear:self];
}

+ (BOOL)isLeapYear:(NSDate *)date {
    NSUInteger year = [date year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)formatYMD {
    return [NSDate formatYMD:self];
}

+ (NSString *)formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date year],[date month], [date day]];
}

- (NSUInteger)weeksOfMonth {
    return [NSDate weeksOfMonth:self];
}

+ (NSUInteger)weeksOfMonth:(NSDate *)date {
    return [[date lastdayOfMonth] weekOfYear] - [[date begindayOfMonth] weekOfYear] + 1;
}

- (NSUInteger)weekOfYear {
    return [NSDate weekOfYear:self];
}

+ (NSUInteger)weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date year];
    
    NSDate *lastdate = [date lastdayOfMonth];
    
    for (i = 1;[[lastdate dateAfterDay:-7 * i] year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)dateAfterDay:(NSUInteger)day {
    return [NSDate dateAfterDate:self day:day];
}

+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)dateAfterMonth:(NSUInteger)month {
    return [NSDate dateAfterDate:self month:month];
}

+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)begindayOfMonth {
    return [NSDate begindayOfMonth:self];
}

+ (NSDate *)begindayOfMonth:(NSDate *)date {
    return [self dateAfterDate:date day:-[date day] + 1];
}

- (NSDate *)lastdayOfMonth {
    return [NSDate lastdayOfMonth:self];
}

+ (NSDate *)lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self begindayOfMonth:date];
    return [[lastDate dateAfterMonth:1] dateAfterDay:-1];
}

- (NSUInteger)daysAgo {
    return [NSDate daysAgo:self];
}

+ (NSUInteger)daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)weekday {
    return [NSDate weekday:self];
}

+ (NSInteger)weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)dayFromWeekday {
    return [NSDate dayFromWeekday:self];
}

+ (NSString *)dayFromWeekday:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

-(BOOL)isSameMonth:(NSDate *)anotherDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]);
}

- (BOOL)isToday {
    return [self isSameDay:[NSDate date]];
}

- (NSDate *)dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date stringWithFormat:format];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];

    outputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //设置格式
    outputFormatter.dateFormat = format;
    
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
//    [outputFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
//    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

- (NSString *)stringWithFormats:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    outputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //设置格式
    outputFormatter.dateFormat = format;
    
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    [outputFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
//     [outputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //设置格式
    
    
//    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//      [inputFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
//    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
    [inputFormatter setDateFormat:format];

    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)daysInMonth:(NSUInteger)month {
    return [NSDate daysInMonth:self month:month];
}

+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)daysInMonth {
    return [NSDate daysInMonth:self];
}

+ (NSUInteger)daysInMonth:(NSDate *)date {
    return [self daysInMonth:date month:[date month]];
}

- (NSString *)timeInfo {
    return [NSDate timeInfoWithDate:self];
}


+ (NSString *)stringWithDate:(NSDate *)date type:(NSInteger)type{
    if (type ==1) {
        return [self stringWithDate:date format:[self ymdHmsFormat]];
    }else if(type ==2){
        return [self stringWithDate:date format:[self hmsFormat]];
    }else{
        return [self stringWithDate:date format:[self ymdFormat]];
    }
}

+(NSString *)stringWithDate:(NSDate *)date types:(NSInteger)types{
    return [self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm:ss  MM/dd"]];
}

+(NSString *)stringWithHSDate:(NSDate *)date{
    
        return [self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]];
    
}

+(NSDate *)dateFromDictionary:(NSDictionary *)dic{
    
    return [self dateFromString:[dic valueForKey:@"iso"]];
    
}

+(NSDateFormatter *)dateFormatter{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:AV_DATE_FORMAT];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    
    return dateFormatter;
}

+(NSDate *)dateFromString:(NSString *)string
{
    if (string == nil || [string isKindOfClass:[NSNull class]]) {
        return [NSDate date];
    }
    
    NSDate *date = [[self.class dateFormatter] dateFromString:string];
    
    return date;
}

+(NSString *)stringWithMYDate:(NSDate *)date{
     return [self stringWithDate:date format:[NSString stringWithFormat:@"MM月dd日"]];
}

+(NSString *)stringmessagetypeWithDate:(NSDate *)date {
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy/MM/dd"]];
}


+(NSString *)stringmessageYearWithDate:(NSDate *)date {
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy"]];
}


+(NSString *)stringmessageMothWithDate:(NSDate *)date {
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy/MM"]];
}

+(NSString *)stringmessageInfoWithDate:(NSDate *)date {
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"MM-dd HH:mm"]];
}

+(NSString *)stringmessagelistWithDate:(NSDate *)date {
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy/MM/dd HH:mm"]];
}


+(NSString *)stringmessagelistWithDatess:(NSDate *)date {
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm"]];
}

+(NSString *)stringmessagelistWithDates:(NSDate *)date {
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
}
+ (NSString *)timeInfoWithDate:(NSDate *)date {
    return [self timeInfoWithDateString:[self stringWithDate:date format:[self ymdHmsFormat]]];
}

+(NSString *)timestrWithDate:(NSDate *)date{
   return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy年MM月dd日"]];
}

+(NSString *)timestrWithDatess:(NSDate *)date{
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy年MM月"]];
}

+(NSString *)timestrWaithWithDate:(NSDate *)date{
     return  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy年MM月dd日 HH:mm"]];
}

+(NSString *)timestrWithDatesss:(NSDate *)date{
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
//    outputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //设置格式
    outputFormatter.dateFormat = @"yyyy年MM月";
    
//    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
    //    [outputFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
//    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *retStr = [outputFormatter stringFromDate:date];
    
    return retStr;
//    return  [self stringWithDate:date format:[NSString stringWithFormat:@"YYYY年MM月"]];
}


+(NSString *)timestrWithCurrentDatess:(NSDate *)date{
    return  [self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]];
}
+ (NSString *)timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self dateWithString:dateString format:[self ymdHmsFormat]];
    
    NSDate *dates = [NSDate new];
    
//    NSString *datestr = [self ]
    
    NSString *timestr = [self stringWithDate:dates format:[self ymdHmsFormat]];
    
    
    NSDate *curDate = [self dateWithString:timestr format:[self ymdHmsFormat]];
    
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate month] - [date month]);
    int year = (int)([curDate year] - [date year]);
    int day = (int)([curDate day] - [date day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate month] == 1 && [date month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self daysInMonth:date month:[date month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate day] + (totalDays - (int)[date day]);
        }
        
        if(retDay <=3){
            return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
        }else{
            NSString *str =  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy/MM/dd"]];
            str = [str stringByReplacingOccurrencesOfString:@"/" withString:@"."];
           
            return str;
        }
        
       
    } else  {
        NSString *str =  [self stringWithDate:date format:[NSString stringWithFormat:@"yyyy/MM/dd"]];
        str = [str stringByReplacingOccurrencesOfString:@"/" withString:@"."];
        return str;
    }
    
}

+ (NSString *)timeStrFormatMMHHDDOrYyyyMmDdWithDate:(NSDate *)tempDate {
    
    if ([tempDate isToday]) {
        NSDate *date = [NSDate convertDateToLocalTime:tempDate] ;
        NSDate *curDate = [NSDate dateNow];
        NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
        NSTimeInterval retTime = 1.0;
        if (time < 3600) { // 小于一小时
            retTime = floor(time / 60);
            retTime = retTime <= 0.0 ? 1.0 : retTime;
            return [NSString stringWithFormat:@"%.0f分钟前", retTime];
        } else{ // 小于一天，也就是今天
            retTime = floor(time / 3600);
            retTime = retTime <= 0.0 ? 1.0 : retTime;
            return [NSString stringWithFormat:@"%.0f小时前", retTime];
        }
    }else if ([tempDate isSameDay:[[NSDate new] dateAfterDay:-1]]){
        return @"昨天";
    }else  {
        NSString *str =  [self stringWithDate:tempDate format:[NSString stringWithFormat:@"yyyy-MM-dd"]];
        return str;
    }
}

- (NSString *)ymdFormat {
    return [NSDate ymdFormat];
}

- (NSString *)hmsFormat {
    return [NSDate hmsFormat];
}

- (NSString *)ymdHmsFormat {
    return [NSDate ymdHmsFormat];
}

+ (NSString *)ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}

+ (NSString *)getTimeStrWithDate:(NSDate *)date {
    NSString *dateStr = @"";
    if ([date isToday]) {
        dateStr = [NSString stringWithFormat:@"今天 %@",[self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]]];
    }else if ([date isSameDay:[[NSDate new] dateAfterDay:1]]){
        dateStr = [NSString stringWithFormat:@"明天 %@",[self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]]];
    }else if ([date isSameDay:[[NSDate new] dateAfterDay:2]]){
        dateStr = [NSString stringWithFormat:@"后天 %@",[self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]]];
    }else {
        dateStr = [NSString stringWithFormat:@"%@",[self stringWithDate:date format:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm"]]];
    }
    return dateStr;
}

+ (NSString *)getBeforeTimeStrWithDate:(NSDate *)date {
    NSString *dateStr = @"";
    if ([date isToday]) {
        dateStr = [NSString stringWithFormat:@"今天 %@",[self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]]];
    }else if ([date isSameDay:[[NSDate new] dateAfterDay:1]]){
        dateStr = [NSString stringWithFormat:@"明天 %@",[self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]]];
    }else if ([date isSameDay:[[NSDate new] dateAfterDay:2]]){
        dateStr = [NSString stringWithFormat:@"后天 %@",[self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]]];
    }else {
        dateStr = [NSString stringWithFormat:@"%@",[self stringWithDate:date format:[NSString stringWithFormat:@"MM-dd HH:mm"]]];
    }
    return dateStr;
}


+ (NSString *)getChuanguanTimeStrWithDate:(NSDate *)date {
    NSString *dateStr = @"";
    if ([date isToday]) {
        dateStr = [NSString stringWithFormat:@"今天 %@",[self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]]];
    }else if ([date isSameDay:[[NSDate new] dateAfterDay:1]]){
        dateStr = [NSString stringWithFormat:@"明天 %@",[self stringWithDate:date format:[NSString stringWithFormat:@"HH:mm"]]];
    }else {
        dateStr = [NSString stringWithFormat:@"%@",[self stringWithDate:date format:[NSString stringWithFormat:@"MM/dd HH:mm"]]];
    }
    return dateStr;
}

- (NSDate *)offsetYears:(int)numYears {
    return [NSDate offsetYears:numYears fromDate:self];
}

+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)offsetMonths:(int)numMonths {
    return [NSDate offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)offsetDays:(int)numDays {
    return [NSDate offsetDays:numDays fromDate:self];
}

+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)offsetHours:(int)hours {
    return [NSDate offsetHours:hours fromDate:self];
}

+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

/**
 *  时间戳转成字符串
 *
 *  @param times 时间戳
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)timeFromTimes:(NSDate *)times{
    
    NSDateFormatter *dateFormtter =[[NSDateFormatter alloc] init];
    NSDate *d = times;
    NSTimeInterval late=[d timeIntervalSince1970]*1;    //转记录的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;   //获取当前时间戳
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString=[NSString stringWithFormat:@"刚刚"];
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }
        
//        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表时间大于1天
    else
    {
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormtter stringFromDate:d];
    }
    
    return timeString;
}



@end
