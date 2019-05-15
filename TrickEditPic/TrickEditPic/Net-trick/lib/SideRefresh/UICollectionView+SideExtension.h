//
//  UICollectionView+SideExtension.h
//  CollectionViewSideRefresh
//
//  Created by dangercheng on 2018/9/12.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (SideExtension)
@property (nonatomic, assign, readonly) UIEdgeInsets side_inset;
@property (nonatomic, assign) CGFloat side_insetL;
@property (nonatomic, assign) CGFloat side_insetR;
@end

@interface HcdProcessView : UIView

/**
 *  比例尺长度
 */
@property (nonatomic, readwrite, assign) CGFloat scaleDivisionsLength;
/**
 *  比例次刻度宽度
 */
@property (nonatomic, readwrite, assign) CGFloat scaleDivisionsWidth;
/**
 *  比例次到self边距
 */
@property (nonatomic, readwrite, assign) CGFloat scaleMargin;
/**
 *  比例尺的个数
 */
@property (nonatomic, readwrite, assign) CGFloat scaleCount;
/**
 *  比例尺到圆形波纹的距离
 */
@property (nonatomic, readwrite, assign) CGFloat waveMargin;
/**
 *  波长
 */
@property (nonatomic, readwrite, assign) CGFloat waveLength;

/**
 * 振幅
 */
@property (nonatomic, readwrite, assign) CGFloat amplitude;
/**
 *  百分比
 */
@property (nonatomic, readwrite, assign) CGFloat percent;
/**
 *  前波浪颜色
 */
@property (nonatomic, readwrite, retain) UIColor *frontWaterColor;
/**
 *  后波浪颜色
 */
@property (nonatomic, readwrite, retain) UIColor *backWaterColor;
/**
 *  波浪的背景颜色
 */
@property (nonatomic, readwrite, retain) UIColor *waterBgColor;
/**
 *  刻度线背景色
 */
@property (nonatomic, readwrite, retain) UIColor *lineBgColor;
/**
 *  刻度线颜色
 */
@property (nonatomic, readwrite, retain) UIColor *scaleColor;
/**
 *  是否显示背景上的线条
 */
@property (nonatomic, readwrite, assign) BOOL showBgLineView;

@end
