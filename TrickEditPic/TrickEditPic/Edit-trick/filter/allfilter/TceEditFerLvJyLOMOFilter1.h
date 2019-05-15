//
//  TceEditFerLvJyLOMOFilter1.h
//  TceEditFerLvJyLifeApp
//
//  Created by Forrest Woo on 16/9/16.
//  Copyright © 2016年 ForrstWoo. All rights reserved.
//

#import "GPUImageFilterGroup.h"

@interface TceEditFerLvJyFilterLOMO : GPUImageTwoInputFilter

@end

@interface TceEditFerLvJyLOMOFilter1 : GPUImageFilterGroup
{
    GPUImagePicture *imageSource1;
    GPUImagePicture *imageSource2;
}
@end
