//
//  UIButton+TCEBtn.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ButtonType){
    ButtonTypeTop,
    ButtonTypeBom,
    ButtonTypeLeft,
    ButtonTypeRight,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TCEBtn)
+ (UIButton *) TCEBtnWithType:(ButtonType)type withButton:(UIButton *)btn withSpace:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
