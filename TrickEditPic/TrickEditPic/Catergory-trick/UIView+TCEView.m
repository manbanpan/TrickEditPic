//
//  UIView+TCEView.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import "UIView+TCEView.h"

@implementation UIView (TCEView)

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}


- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (BOOL)edit_isShowingOnKeyWindow
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

+ (instancetype)TCEViewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

#pragma mark - 控制器
+ (UIViewController * )TCEGetVcWithView:(UIView *)views
{
    UIResponder * next = [views nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[UIViewController class]]){
            return (UIViewController * )next;
        }
        next = [next nextResponder];
    }
    return nil;
}

#pragma mark - 获取导航控制器
+ (UINavigationController * )TCEGetNavVcWithView:(UIView *)views
{
    UIResponder * next = [views nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[UINavigationController class]]){
            return (UINavigationController * )next;
        }
        next = [next nextResponder];
    }
    return nil;
}

- (UIImage *)TCEGetImageWithFrame:(CGRect)rect
{
    UIImage* image = nil;
    
    BOOL translateCTM = !CGRectEqualToRect(CGRectZero, rect);
    
    if (!translateCTM) {
        rect = self.frame;
    }
    
    rect.origin.x = (rect.origin.x+FLT_EPSILON);
    rect.origin.y = (rect.origin.y+FLT_EPSILON);
    rect.size.width = (rect.size.width+FLT_EPSILON);
    rect.size.height = (rect.size.height+FLT_EPSILON);
    
    CGSize size = rect.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (translateCTM)
    {
        CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    }
    
    [self.layer renderInContext: context];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

/****************************************************************/
//画直线 - draw line in view.
- (void)jh_drawLineFromPoint:(CGPoint)fPoint
                     toPoint:(CGPoint)tPoint
                   lineColor:(UIColor *)color
                  lineHeight:(CGFloat)height
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:fPoint];
        [path addLineToPoint:tPoint];
        path.CGPath;
    });
    shapeLayer.lineWidth = height;
    [self.layer addSublayer:shapeLayer];
}

//画虚线 - draw dash line.
- (void)jh_drawDashLineFromPoint:(CGPoint)fPoint
                         toPoint:(CGPoint)tPoint
                       lineColor:(UIColor *)color
                       lineWidth:(CGFloat)width
                      lineHeight:(CGFloat)height
                       lineSpace:(CGFloat)space
                        lineType:(NSInteger)type
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:fPoint];
        [path addLineToPoint:tPoint];
        path.CGPath;
    });
    //第一格虚线缩进多少 - the degree of indent of the first cell
    //shapeLayer.lineDashPhase = 4;
    shapeLayer.lineWidth = height < 0 ? 1 : height;
    shapeLayer.lineCap = kCALineCapButt;
    width = width < 0 ? 1 : width;
    shapeLayer.lineDashPattern = @[@(width),@(space)];
    if (type == 1) {
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineDashPattern = @[@(width),@(space+width)];
    }
    [self.layer addSublayer:shapeLayer];
}

- (void)jh_drawPentagram:(CGPoint)center
                  radius:(CGFloat)radius
                   color:(UIColor *)color
                    rate:(CGFloat)rate
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    if (color) {
        shapeLayer.fillColor = color.CGColor;
    }
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        //五角星最上面的点
        CGPoint first  = CGPointMake(center.x, center.y-radius);
        
        [path moveToPoint:first];
        
        //点与点之间点夹角为2*M_PI/5.0,要隔一个点才连线
        CGFloat angle=4*M_PI/5.0;
        if (rate > 1.5) {
            rate = 1.5;
        }
        for (int i= 1; i <= 5; i++) {
            CGFloat x = center.x - sinf(i*angle)*radius;
            CGFloat y = center.y - cosf(i*angle)*radius;
            
            CGFloat midx = center.x - sinf(i*angle-2*M_PI/5.0)*radius*rate;
            CGFloat midy = center.y - cosf(i*angle-2*M_PI/5.0)*radius*rate;
            [path addQuadCurveToPoint:CGPointMake(x, y) controlPoint:CGPointMake(midx, midy)];
        }
        
        path.CGPath;
    });
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:shapeLayer];
}

- (void)jh_drawRect:(CGRect)rect
          lineColor:(UIColor *)color
          lineWidth:(CGFloat)width
         lineHeight:(CGFloat)height
           lineType:(NSInteger)type
             isDash:(BOOL)dash
          lineSpace:(CGFloat)space
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = [UIBezierPath bezierPathWithRect:rect].CGPath;
    shapeLayer.lineWidth = height < 0 ? 1 : height;
    shapeLayer.lineCap = kCALineCapButt;
    if (type == 1) {
        shapeLayer.lineCap = kCALineCapRound;
    }
    
    width = width < 0 ? 1 : width;
    if (dash) {
        shapeLayer.lineDashPattern = @[@(width),@(space)];
        if (type == 1) {
            shapeLayer.lineDashPattern = @[@(width),@(space+width)];
        }
    }
    
    [self.layer addSublayer:shapeLayer];
}

- (CALayer *)jh_gradientLayer:(CGRect)rect
                        color:(NSArray <UIColor *>*)colors
                     location:(NSArray <NSNumber *> *)locations
                    direction:(CAGradientLayerDirection)direction
{
    if (colors.count == 0) {
        return nil;
    }
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = rect;
    layer.locations = locations;
    layer.colors = ({
        NSMutableArray *marr = @[].mutableCopy;
        for (UIColor *color in colors) {
            if ([color isKindOfClass:[UIColor class]]) {
                [marr addObject:(__bridge id)color.CGColor];
            }
        }
        marr;
    });
    
    if (direction == CAGradientLayerDirection_FromLeftToRight) {
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint   = CGPointMake(1, 0);
    }else if (direction == CAGradientLayerDirection_FromTopToBottom) {
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint   = CGPointMake(0, 1);
    }else if (direction == CAGradientLayerDirection_FromTopLeftToBottomRight) {
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint   = CGPointMake(1, 1);
    }else if (direction == CAGradientLayerDirection_FromTopRightToBottomLeft) {
        layer.startPoint = CGPointMake(1, 0);
        layer.endPoint   = CGPointMake(0, 1);
    }else if (direction == CAGradientLayerDirection_FromCenterToEdge) {
        layer.startPoint = CGPointMake(0.5, 0.5);
        layer.endPoint   = CGPointMake(1, 1);
        layer.type = kCAGradientLayerRadial;
    }
    
    [self.layer addSublayer:layer];
    return layer;
}



@end
