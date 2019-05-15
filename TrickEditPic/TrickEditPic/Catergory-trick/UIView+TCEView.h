//
//  UIView+TCEView.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CAGradientLayerDirection) {
    CAGradientLayerDirection_FromLeftToRight,           // 从左到右
    CAGradientLayerDirection_FromTopToBottom,           // 从上到下
    CAGradientLayerDirection_FromTopLeftToBottomRight,  // 从左上到右下
    CAGradientLayerDirection_FromTopRightToBottomLeft,  // 从右上到左下
    CAGradientLayerDirection_FromCenterToEdge,          // 从中心向四周
};




@interface UIView (TCEView)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

+ (instancetype)TCEViewFromXib;
+ (UIViewController * )TCEGetVcWithView:(UIView *)views;
+ (UINavigationController * )TCEGetNavVcWithView:(UIView *)views;
- (UIImage *)TCEGetImageWithFrame:(CGRect)rect;

/********************************************************/
- (void)jh_drawLineFromPoint:(CGPoint)fPoint
                     toPoint:(CGPoint)tPoint
                   lineColor:(UIColor *)color
                  lineHeight:(CGFloat)height;

/// draw dash line in view. type: 0 - cube, 1 - round
- (void)jh_drawDashLineFromPoint:(CGPoint)fPoint
                         toPoint:(CGPoint)tPoint
                       lineColor:(UIColor *)color
                       lineWidth:(CGFloat)width
                      lineHeight:(CGFloat)height
                       lineSpace:(CGFloat)space
                        lineType:(NSInteger)type;

/// draw pentagram in view. rate: 0.3 ~ 1.1
- (void)jh_drawPentagram:(CGPoint)center
                  radius:(CGFloat)radius
                   color:(UIColor *)color
                    rate:(CGFloat)rate;

/// draw rect. type: 0 - cube, 1 - round
- (void)jh_drawRect:(CGRect)rect
          lineColor:(UIColor *)color
          lineWidth:(CGFloat)width
         lineHeight:(CGFloat)height
           lineType:(NSInteger)type
             isDash:(BOOL)dash
          lineSpace:(CGFloat)space;

/// gradient layer with direction.
- (CALayer *)jh_gradientLayer:(CGRect)rect
                        color:(NSArray <UIColor *>*)colors
                     location:(NSArray <NSNumber *> *)locations
                    direction:(CAGradientLayerDirection)direction;


@end

NS_ASSUME_NONNULL_END
