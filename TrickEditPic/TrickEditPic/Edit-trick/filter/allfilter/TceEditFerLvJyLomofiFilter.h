//
//  TceEditFerLvJyLomofiFilter.h
//  TceEditFerLvJyMeituApp
//
//  Created by hzkmn on 16/1/11.
//  Copyright © 2016年 ForrestWoo co,.ltd. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@interface TceEditFerLvJyFilter6 : GPUImageThreeInputFilter

@end

@interface TceEditFerLvJyLomofiFilter : GPUImageFilterGroup
{
    GPUImagePicture *imageSource1;
    GPUImagePicture *imageSource2;
}

@end
