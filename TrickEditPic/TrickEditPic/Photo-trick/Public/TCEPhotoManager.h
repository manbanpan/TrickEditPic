//
//  TCEPhotoManager.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCEPhotoPublic.h"
NS_ASSUME_NONNULL_BEGIN

@interface TCEPhotoManager : NSObject

+(void)tceGetAllPhoto:(void(^)(PHFetchResult *result))allPhotoBlock;
+(void)tceGetChoosePhoto:(PHAsset *)asset viewSize:(CGSize)size image:(void(^)(UIImage *result))resultBlock;
@end

NS_ASSUME_NONNULL_END
