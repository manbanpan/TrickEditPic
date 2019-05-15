//
//  TceEditCuttingView.h
//  Picture Editing
//
//  Created by zzb on 2019/4/11.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TceEditRatio;
@interface TceEditCuttingView : UIView

@property (nonatomic, assign) CGRect clippingRect;
@property (nonatomic, strong) TceEditRatio *tceEditCuttingRatio;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *gridColor;
@property (nonatomic, strong) NSDictionary *ratioDic ;


- (id)initWithSuperview:(UIView*)superview frame:(CGRect)frame;

@end

@interface TceEditBtnCircle : UIView

@end

@interface TceEditGridLayer : CALayer

@property (nonatomic, assign) CGRect  tceEdit_rect; //裁剪范围
@property (nonatomic, strong) UIColor *tceEdit_bgColor;    //背景颜色
@property (nonatomic, strong) UIColor *tceEdit_gridColor;  //线条颜色

@end

@interface TceEditRatio : NSObject

@property (nonatomic, assign) BOOL isLandscape;
@property (nonatomic, readonly) CGFloat ratio;

- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2;
@end;
