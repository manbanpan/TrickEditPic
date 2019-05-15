//
//  TCEPhotoFrameView.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TCEPhotoFrameView;
@protocol TCEPhotoFrameViewDelegate <NSObject>
@required
- (void)tceFrameView:(TCEPhotoFrameView *)frameView didGraValue:(CGFloat)value;
- (void)tceFrameView:(TCEPhotoFrameView *)frameView didBorderValue:(CGFloat)value;

@end

@interface TCEPhotoFrameView : UIView

@property (nonatomic,   weak)id<TCEPhotoFrameViewDelegate> delegates;

@end

NS_ASSUME_NONNULL_END
