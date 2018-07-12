//
//  UILabel+CAPAdjustFont.m
//  Capacap
//
//  Created by hejingjin on 2017/11/28.
//  Copyright © 2017年 kingyon. All rights reserved.
//

#import "UILabel+CAPAdjustFont.h"

@implementation UILabel (CAPAdjustFont)


+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
//        if(self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
//            self.font = [UIFont systemFontOfSize:fontSize];
        
        self.font = [UIFont fontWithName:self.font.fontName size:fontSize];
//        }
    }
    return self;
}
@end
