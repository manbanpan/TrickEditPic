//
//  TceEditFerLvJyLordKelvinFilter.h
//  TceEditFerLvJyMeituApp
//
//  Created by hzkmn on 16/1/8.
//  Copyright © 2016年 ForrestWoo co,.ltd. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@interface TceEditFerLvJyFilter2 : GPUImageTwoInputFilter

@end

@interface TceEditFerLvJyLordKelvinFilter : GPUImageFilterGroup
{
    GPUImagePicture *imageSource;
}

@end
