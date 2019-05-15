//
//  TCEPhotoSizeView.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TCEPhotoSizeView;
@protocol TCEPhotoSizeViewDelegate <NSObject>
@required

- (void)tceSizeView:(TCEPhotoSizeView *)sizeView didSelectRatio:(CGFloat)ratio;

@end

@interface TCEPhotoSizeView : UIView

@property (nonatomic,   weak)id<TCEPhotoSizeViewDelegate> delegates;

@end

NS_ASSUME_NONNULL_END
