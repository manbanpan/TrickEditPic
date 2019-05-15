//
//  TceEditAdjustManager.m
//  Picture Editing
//
//  Created by zzb on 2019/4/11.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditAdjustManager.h"

@implementation TceEditAdjustManager
+ (UIImage *)tceEdit_changeValueForBrightness:(float)value image:(UIImage *)image;
{
    GPUImageBrightnessFilter *filter = [[GPUImageBrightnessFilter alloc] init];
    filter.brightness = value;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+ (UIImage *)tceEdit_changeValueForContrast:(float)value image:(UIImage *)image;
{
    GPUImageContrastFilter *filter = [[GPUImageContrastFilter alloc] init];
    filter.contrast = value;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+ (UIImage *)tceEdit_changeValueForSaturation:(float)value image:(UIImage *)image;
{
    GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init];
    filter.saturation = value;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
//色温
+ (UIImage *)tceEdit_changeValueForWhiteBalance:(float)value image:(UIImage *)image
{
    GPUImageWhiteBalanceFilter *filter = [[GPUImageWhiteBalanceFilter alloc] init];
    filter.temperature = value;
    filter.tint = 0.0;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+ (UIImage *)tceEdit_changeValueForSharpen:(float)value image:(UIImage *)image
{
    GPUImageSharpenFilter *filter = [[GPUImageSharpenFilter alloc] init];
    filter.sharpness = value;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

@end
