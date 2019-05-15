//
//  UIImage+TCEImge.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/8.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (TCEImge)
- (UIImage*)crop:(CGRect)rect;
- (UIImage *)imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

/**
 图片切割成指定大小

 @param image 需要处理的图片
 @param size 大小
 @return 新image
 */
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage;
@end

NS_ASSUME_NONNULL_END
