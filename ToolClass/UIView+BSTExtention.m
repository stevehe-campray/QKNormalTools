//
//  UIView+BSTExtention.m

//
//  Created by hejingjin on 16/7/19.

//

#import "UIView+BSTExtention.h"

@implementation UIView (BSTExtention)

- (void)setBst_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)bst_size
{
    return self.frame.size;
}

- (void)setBst_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setBst_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setBst_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setBst_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setBst_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setBst_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)bst_centerY
{
    return self.center.y;
}

- (CGFloat)bst_centerX
{
    return self.center.x;
}

- (CGFloat)bst_width
{
    return self.frame.size.width;
}

- (CGFloat)bst_height
{
    return self.frame.size.height;
}

- (CGFloat)bst_x
{
    return self.frame.origin.x;
}

- (CGFloat)bst_y
{
    return self.frame.origin.y;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


-(void)bst_addCornerWithradius:(CGFloat)radius{
    
    [self bst_addCornerWithradius:radius borderWidth:1.f backgroundColor:[UIColor clearColor] borderColor:[UIColor blackColor]];
}

-(void)bst_addCornerWithradius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroucdcolor borderColor:(UIColor *)borderColor{
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[self bst_drawrectWithradius:radius borderWidth:borderWidth backgroundColor:backgroucdcolor borderColor:borderColor]];
    
//    [self insertSubview:imageview atIndex:0];
    [self addSubview:imageview];
    [self bringSubviewToFront:imageview];
    
    
    
}

-(UIImage *)bst_drawrectWithradius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroucdcolor borderColor:(UIColor *)borderColor{
    
//    let sizeToFit = CGSize(width: pixel(Double(self.bounds.size.width)), height: Double(self.bounds.size.height))
    
    CGSize sizeToFit = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    CGFloat halfBorderWidth = borderWidth / 2.0;
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, false, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, backgroucdcolor.CGColor);
    
    CGFloat width = sizeToFit.width;
    CGFloat height = sizeToFit.height;
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
    
}
@end
