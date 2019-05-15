//
//  TcePuzzlePuzzleEditScrollView.h
//  ConstellationCamera
//
//  Created by zzb on 2019/1/9.
//  Copyright © 2019年 ConstellationCamera. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TcePuzzlePuzzleEditScrollView;
@protocol TcePuzzlePuzzleEditScrollViewDelegate <NSObject>
- (void)TcePuzzleTapWithEditView:(TcePuzzlePuzzleEditScrollView *)editView;
@end


@interface TcePuzzlePuzzleEditScrollView : UIScrollView
@property (nonatomic, assign) id<TcePuzzlePuzzleEditScrollViewDelegate> editDelegate;
@property (nonatomic, retain) UIBezierPath  *TcePuzzleRealCellPath;
@property (nonatomic, retain) UIImageView   *TcePuzzleImageView;
@property (nonatomic, assign) CGRect        TcePuzzleOldRect;

- (void)setNotReloadFrame:(CGRect)frame;
- (void)setImageViewData:(UIImage *)image;
- (void)setImageViewData:(UIImage *)image rect:(CGRect)rect;
@end

/******************************************************************/
@class TSMneuLabel;
typedef void(^TSMneuLabelHandler)(TSMneuLabel * menuLabel);

typedef NS_ENUM(NSInteger, TSMneuLabelMenuType) {
    TSMneuLabelTypeDefault,//啥也没有
    TSMneuLabelTypeCopy = 1,//只有复制
    TSMneuLabelTypeDemo,//栗子
    
};

typedef NS_ENUM(NSInteger, TSMneuLabelGestureType) {
    TSMneuLabelGestureTypeNone,//强制不作处理
    TSMneuLabelGestureTypeDefault = 0,//没赋值会走tap
    TSMneuLabelGestureTypeTap,//默认单击
    TSMneuLabelGestureTypeLongTap,//长按
};


@interface TSMneuLabel : UILabel

@property (assign, nonatomic)TSMneuLabelMenuType menuType;//弹窗类型
@property (assign, nonatomic)TSMneuLabelGestureType gestureType;//手势类型

@property (strong, nonatomic)TSMneuLabelHandler actionHandler;//暂时用不到 , 用于点击事件的往外传
/**
 初始化方法
 
 @param menuType 弹窗类型
 @param gestureType 手势类型
 @return 返回label
 */
+ (instancetype)mneuLabelWithMenuType:(TSMneuLabelMenuType)menuType
                       andGestureType:(TSMneuLabelGestureType)gestureType;

/**
 初始化方法
 
 @param menuType 弹窗类型
 @param gestureType 手势类型
 @return 返回label
 */
- (instancetype)initWithMenuType:(TSMneuLabelMenuType)menuType
                  andGestureType:(TSMneuLabelGestureType)gestureType;

/**
 万能初始化方法
 
 @param frame frame
 @param menuType 弹窗类型
 @param gestureType 手势类型
 @return 返回label
 */
- (instancetype)initWithFrame:(CGRect)frame
                  andMenuType:(TSMneuLabelMenuType)menuType
               andGestureType:(TSMneuLabelGestureType)gestureType;

@end
