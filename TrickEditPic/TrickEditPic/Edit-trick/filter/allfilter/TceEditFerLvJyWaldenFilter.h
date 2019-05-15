//
//  TceEditFerLvJyWaldenFilter.h
//  TceEditFerLvJyMeituApp
//
//  Created by hzkmn on 16/1/11.
//  Copyright © 2016年 ForrestWoo co,.ltd. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@interface TceEditFerLvJyFilter7 : GPUImageThreeInputFilter

@end

@interface TceEditFerLvJyWaldenFilter : GPUImageFilterGroup
{
    GPUImagePicture *imageSource1;
    GPUImagePicture *imageSource2;
}

@end
