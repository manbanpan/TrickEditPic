//
//  TceEditFerLvJyValenciaFilter.h
//  TceEditFerLvJyMeituApp
//
//  Created by hzkmn on 16/1/11.
//  Copyright © 2016年 ForrestWoo co,.ltd. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@interface TceEditFerLvJyFilter8 : GPUImageThreeInputFilter

@end

@interface TceEditFerLvJyValenciaFilter : GPUImageFilterGroup
{
    GPUImagePicture *imageSource1;
    GPUImagePicture *imageSource2;
}

@end
