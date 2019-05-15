//
//  TceEditTabBarView.h
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TceEditTabBarView;
@protocol TceEditTabBarViewDelegate <NSObject>
- (void)TceEditTabBarView:(TceEditTabBarView *)barView selectBarItem:(UIButton *)item;
@end

@interface TceEditTabBarView : UIView
@property (nonatomic,   weak)id<TceEditTabBarViewDelegate> delegate;

@end
