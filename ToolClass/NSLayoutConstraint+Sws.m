//
//  NSLayoutConstraint+Sws.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "NSLayoutConstraint+Sws.h"
#import "QKNormalTools.h"
@implementation NSLayoutConstraint (Sws)

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // 线 navBar TabBar
    if (0.5 == self.constant ||1.0 == self.constant|| 49 == self.constant || 64 == self.constant || 20 == self.constant) {
        
        return;
    }
    
    // width
    if (self.firstAttribute == NSLayoutAttributeLeading || self.firstAttribute == NSLayoutAttributeTrailing|| self.firstAttribute == NSLayoutAttributeCenterX || self.firstAttribute == NSLayoutAttributeWidth) {
        
        self.constant = self.constant * KWidth_Scale;
    }
    
    // height
    if (self.firstAttribute == NSLayoutAttributeTop || self.firstAttribute == NSLayoutAttributeBottom || self.firstAttribute == NSLayoutAttributeCenterY || self.firstAttribute == NSLayoutAttributeHeight) {
        
        self.constant = self.constant * KWidth_Scale;
    }
}

@end
