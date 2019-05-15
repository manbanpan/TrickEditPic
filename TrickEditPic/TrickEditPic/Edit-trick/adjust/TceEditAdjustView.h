//
//  TceEditAdjustView.h
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TceEditAdjustView : UIView
@property (nonatomic,   copy)void(^adjustBlock) (CGFloat value,NSInteger item);
@property (nonatomic,   copy)void(^adjustSuccesBlock) (void);

@end

@interface TceEditAdjustModel : NSObject

@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat Value;
@end


/******************************************/
@interface DSMagnifierView : UIWindow

@property (nonatomic, strong) UIView *renderView;
@property (nonatomic, assign) CGPoint renderPoint;

@end

