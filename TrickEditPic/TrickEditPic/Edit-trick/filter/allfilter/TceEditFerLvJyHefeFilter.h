//
//  TceEditFerLvJyHefeFilter.h
//  TceEditFerLvJyMeituApp
//
//  Created by hzkmn on 16/1/11.
//  Copyright © 2016年 ForrestWoo co,.ltd. All rights reserved.
//

#import "GPUImageFilterGroup.h"
#import "TceEditFerLvJySixInputFilter.h"

@interface TceEditFerLvJyFilter17 : TceEditFerLvJySixInputFilter

@end

@interface TceEditFerLvJyHefeFilter : GPUImageFilterGroup
{
    GPUImagePicture *imageSource1;
    GPUImagePicture *imageSource2;
    GPUImagePicture *imageSource3;
    GPUImagePicture *imageSource4;
    GPUImagePicture *imageSource5;
}

@end
