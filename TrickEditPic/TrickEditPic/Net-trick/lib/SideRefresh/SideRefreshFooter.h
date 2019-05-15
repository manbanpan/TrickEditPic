//
//  SideRefreshFooter.h
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "SideRefresh.h"

@interface SideRefreshFooter : SideRefresh

@end

@interface CircleView : UIView
@property (nonatomic,strong) CAShapeLayer *backgroundLine;
@property (nonatomic,strong) CAShapeLayer *mainLine;
@property (nonatomic,assign) CGFloat strokelineWidth;
@property (nonatomic,strong) NSTimer *labelTimer;
- (void)circleWithProgress:(NSInteger)progress andIsAnimate:(BOOL)animate;

@end
