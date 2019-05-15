//
//  TceEditAllFilterManager.m
//  Picture Editing
//
//  Created by zzb on 2019/4/11.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditAllFilterManager.h"
static NSArray *allFilters;

@implementation TceEditAllFilterManager
+(UIImage *)tceEdit_Change1977:(UIImage *)image;
{
    TceEditFerLvJy1977Filter *filter = [[TceEditFerLvJy1977Filter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeAmaro:(UIImage *)image;
{
    TceEditFerLvJyAmaroFilter *filter = [[TceEditFerLvJyAmaroFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeBrannan:(UIImage *)image;
{
    TceEditFerLvJyBrannanFilter *filter = [[TceEditFerLvJyBrannanFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeEarlybird:(UIImage *)image;
{
    TceEditFerLvJyEarlybirdFilter *filter = [[TceEditFerLvJyEarlybirdFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+(UIImage *)tceEdit_ChangeHefe:(UIImage *)image;
{
    TceEditFerLvJyHefeFilter *filter = [[TceEditFerLvJyHefeFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
    
}
+(UIImage *)tceEdit_ChangeHudson:(UIImage *)image;
{
    TceEditFerLvJyHudsonFilter *filter = [[TceEditFerLvJyHudsonFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeInkwell:(UIImage *)image;
{
    TceEditFerLvJyInkwellFilter *filter = [[TceEditFerLvJyInkwellFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeLomofi:(UIImage *)image;
{
    TceEditFerLvJyLomofiFilter *filter = [[TceEditFerLvJyLomofiFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeLordKelvin:(UIImage *)image;
{
    TceEditFerLvJyLordKelvinFilter *filter = [[TceEditFerLvJyLordKelvinFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeNashville:(UIImage *)image;
{
    TceEditFerLvJyNashvilleFilter *filter = [[TceEditFerLvJyNashvilleFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeSierra:(UIImage *)image;
{
    TceEditFerLvJySierraFilter *filter = [[TceEditFerLvJySierraFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+(UIImage *)tceEdit_ChangeSutro:(UIImage *)image;
{
    TceEditFerLvJySutroFilter *filter = [[TceEditFerLvJySutroFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeToaster:(UIImage *)image;
{
    TceEditFerLvJyToasterFilter*filter = [[TceEditFerLvJyToasterFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeValencia:(UIImage *)image;
{
    TceEditFerLvJyValenciaFilter *filter = [[TceEditFerLvJyValenciaFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeWalden:(UIImage *)image;
{
    TceEditFerLvJyWaldenFilter *filter = [[TceEditFerLvJyWaldenFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(UIImage *)tceEdit_ChangeXproII:(UIImage *)image;
{
    TceEditFerLvJyXproIIFilter *filter = [[TceEditFerLvJyXproIIFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+(UIImage *)tceEdit_ChangeLomo1:(UIImage *)image;
{
    TceEditFerLvJyLOMOFilter1 *filter = [[TceEditFerLvJyLOMOFilter1 alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+ (UIImage *)tceEdit_ChangeAmatorkaFilter:(UIImage *)image
{
    GPUImageAmatorkaFilter *filter = [[GPUImageAmatorkaFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+ (UIImage *)tceEdit_ChangeMissetikateFilter:(UIImage *)image
{
    GPUImageMissEtikateFilter *filter = [[GPUImageMissEtikateFilter alloc] init];
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+ (UIImage *)tceEdit_ChangeSoftEleganceFilter:(UIImage *)image
{
    GPUImageSoftEleganceFilter *filter = [[GPUImageSoftEleganceFilter alloc] init];
    [filter forceProcessingAtSize:CGSizeMake(image.size.width / 2.0, image.size.height / 2.0)];
    GPUImagePicture *tceEdit = [[GPUImagePicture alloc] initWithImage:image];
    [tceEdit addTarget:filter];
    
    [tceEdit processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}
+(NSArray *)tceEdit_Name
{
    if (NO) {
        return @[@"原图",     @"粉红", @"罗马",  @"布兰南",  @"淡雅",    @"合肥" ,@"哈德森", @"墨色" ,@"LOMO", @"棕黄", @"纳什维尔",@"内华达",@"Sutro",@"傍晚",@"瓦伦西亚",@"瓦尔登",@"XproII",@"LOMO1",@"恋爱",@"凯特",@"优雅"];
    }else{
        return @[@"Original",@"Pink", @"Amaro",@"Brannan",@"Elegant",@"Hefe",@"HDudson",@"Inkwell",@"Lomo",@"LordKelvin",@"Nashville",@"Sierra",@"Sutro",@"Dusk",@"Valencia",@"Walden",@"XproII",@"Lomo1",@"Amator",@"Kate",@"Elegance"];
    }
}

+(NSArray *)tceEditAllNewImgWithFilter;
{
    if (allFilters) {
        return allFilters;
    }
    UIImage *smallImg = [UIImage imageNamed:@"filterdemo"];
    NSArray *arr = @[
             smallImg,
             [TceEditAllFilterManager tceEdit_Change1977:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeAmaro:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeBrannan:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeEarlybird:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeHefe:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeHudson:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeInkwell:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeLomofi:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeLordKelvin:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeNashville:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeSierra:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeSutro:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeToaster:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeValencia:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeWalden:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeXproII:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeAmatorkaFilter:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeMissetikateFilter:smallImg],
             [TceEditAllFilterManager tceEdit_ChangeSoftEleganceFilter:smallImg]
             ];
    allFilters = arr;
    return arr;
}

+(UIImage *)tceEdit_newImageWithItem:(NSInteger)item oldImage:(UIImage *)image;
{
    UIImage *newImage;
    switch (item) {
        case 0:
        {
            newImage = image;
        }
            
            break;
        case 1:
            newImage =  [TceEditAllFilterManager tceEdit_Change1977:image];
            break;
        case 2:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeAmaro:image];
            break;
        case 3:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeBrannan:image];
            break;
        case 4:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeEarlybird:image];
            break;
        case 5:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeHefe:image];
            break;
        case 6:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeHudson:image];
            break;
        case 7:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeInkwell:image];
            break;
        case 8:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeLomofi:image];
            break;
        case 9:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeLordKelvin:image];
            break;
        case 10:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeNashville:image];
            break;
        case 11:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeSierra:image];
            break;
        case 12:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeSutro:image];
            break;
            
        case 13:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeToaster:image];
            break;
            
        case 14:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeValencia:image];
            break;
            
        case 15:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeWalden:image];
            break;
            
        case 16:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeXproII:image];
            break;
            
        case 17:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeAmatorkaFilter:image];
            break;
        case 18:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeMissetikateFilter:image];
            break;
            
        case 19:
            
            newImage =  [TceEditAllFilterManager tceEdit_ChangeSoftEleganceFilter:image];
            break;
        case 20:
            
            newImage =  [TceEditAllFilterManager tceEdit_Change1977:image];
            break;
            
        default:
            break;
    }
    return newImage;
}

@end
