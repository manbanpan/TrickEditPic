//
//  TceEditAdjustManager.h
//  Picture Editing
//
//  Created by zzb on 2019/4/11.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TceEditAdjustManager : NSObject
+ (UIImage *)tceEdit_changeValueForBrightness:(float)value image:(UIImage *)image;
+ (UIImage *)tceEdit_changeValueForContrast:(float)value image:(UIImage *)image;
+ (UIImage *)tceEdit_changeValueForSaturation:(float)value image:(UIImage *)image;
+ (UIImage *)tceEdit_changeValueForWhiteBalance:(float)value image:(UIImage *)image;
+ (UIImage *)tceEdit_changeValueForSharpen:(float)value image:(UIImage *)image;
@end
