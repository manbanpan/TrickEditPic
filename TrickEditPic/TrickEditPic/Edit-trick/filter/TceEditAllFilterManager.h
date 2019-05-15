//
//  TceEditAllFilterManager.h
//  Picture Editing
//
//  Created by zzb on 2019/4/11.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TceEditFerLvJy1977Filter.h"
#import "TceEditFerLvJyAmaroFilter.h"
#import "TceEditFerLvJyBrannanFilter.h"
#import "TceEditFerLvJyEarlybirdFilter.h"
#import "TceEditFerLvJyFiveInputFilter.h"
#import "TceEditFerLvJyHefeFilter.h"
#import "TceEditFerLvJyHudsonFilter.h"
#import "TceEditFerLvJyInkwellFilter.h"
#import "TceEditFerLvJyLomofiFilter.h"
#import "TceEditFerLvJyLordKelvinFilter.h"
#import "TceEditFerLvJyNashvilleFilter.h"
#import "TceEditFerLvJyRiseFilter.h"
#import "TceEditFerLvJySierraFilter.h"
#import "TceEditFerLvJySixInputFilter.h"
#import "TceEditFerLvJySutroFilter.h"
#import "TceEditFerLvJyToasterFilter.h"
#import "TceEditFerLvJyValenciaFilter.h"
#import "TceEditFerLvJyWaldenFilter.h"
#import "TceEditFerLvJyXproIIFilter.h"
#import "TceEditFerLvJyLOMOFilter1.h"
@interface TceEditAllFilterManager : NSObject
+(UIImage *)tceEdit_Change1977:(UIImage *)image;
+(UIImage *)tceEdit_ChangeAmaro:(UIImage *)image;
+(UIImage *)tceEdit_ChangeBrannan:(UIImage *)image;
+(UIImage *)tceEdit_ChangeEarlybird:(UIImage *)image;
+(UIImage *)tceEdit_ChangeHefe:(UIImage *)image;
+(UIImage *)tceEdit_ChangeHudson:(UIImage *)image;
+(UIImage *)tceEdit_ChangeInkwell:(UIImage *)image;
+(UIImage *)tceEdit_ChangeLomofi:(UIImage *)image;
+(UIImage *)tceEdit_ChangeLordKelvin:(UIImage *)image;
+(UIImage *)tceEdit_ChangeNashville:(UIImage *)image;
+(UIImage *)tceEdit_ChangeSierra:(UIImage *)image;
+(UIImage *)tceEdit_ChangeSutro:(UIImage *)image;
+(UIImage *)tceEdit_ChangeToaster:(UIImage *)image;
+(UIImage *)tceEdit_ChangeValencia:(UIImage *)image;
+(UIImage *)tceEdit_ChangeWalden:(UIImage *)image;
+(UIImage *)tceEdit_ChangeXproII:(UIImage *)image;
+(UIImage *)tceEdit_ChangeLomo1:(UIImage *)image;
+(UIImage *)tceEdit_ChangeAmatorkaFilter:(UIImage *)image;
+(UIImage *)tceEdit_ChangeMissetikateFilter:(UIImage *)image;
+(UIImage *)tceEdit_ChangeSoftEleganceFilter:(UIImage *)image;
+(NSArray *)tceEdit_Name;
+(NSArray *)tceEditAllNewImgWithFilter;
+(UIImage *)tceEdit_newImageWithItem:(NSInteger)item oldImage:(UIImage *)image;
@end
