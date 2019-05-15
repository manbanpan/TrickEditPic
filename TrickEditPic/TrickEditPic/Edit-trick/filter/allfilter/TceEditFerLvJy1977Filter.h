//
//  TceEditFerLvJy1977Filter.h
//  TceEditFerLvJyMeituApp
//
//  Created by hzkmn on 16/1/11.
//  Copyright © 2016年 ForrestWoo co,.ltd. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@interface TceEditFerLvJyFilter9 : GPUImageThreeInputFilter

@end

@interface TceEditFerLvJy1977Filter : GPUImageFilterGroup
{
    GPUImagePicture *imageSource1;
    GPUImagePicture *imageSource2;
}

@end
