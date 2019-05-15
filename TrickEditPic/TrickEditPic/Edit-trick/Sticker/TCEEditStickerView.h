//
//  TCEStickerView.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/10.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCEEditStickerView : UIView
@property (nonatomic,   copy)void(^tceStickerBlock) (UIImage *image);

@end

NS_ASSUME_NONNULL_END
