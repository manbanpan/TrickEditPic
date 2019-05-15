//
//  TCEPhotoManager.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPhotoManager.h"

@implementation TCEPhotoManager

+(void)tceGetAllPhoto:(void(^)(PHFetchResult *result))allPhotoBlock
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
       
         if (status == PHAuthorizationStatusAuthorized){
             
             dispatch_async(dispatch_get_global_queue(0, 0), ^{
                 
                 PHFetchResult *fetch = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil ];
                 
                 if (fetch.count != 0) {
                     
                     //获取资源时的参数
                     PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
                     //按时间排序
                     allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
                     //所有照片
                     PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
                     
                     allPhotoBlock(allPhotos);
                 }
             });
         }
        
    }];
}


+(void)tceGetChoosePhoto:(PHAsset *)asset viewSize:(CGSize)size image:(void(^)(UIImage *result))resultBlock
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = true;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.networkAccessAllowed = YES;
    options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        /*
         Progress callbacks may not be on the main thread. Since we're updating
         the UI, dispatch to the main queue.
         */
    };
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
        // Hide the progress view now the request has completed.
        
        // Check if the request was successful.
        
        resultBlock(result);
        
    }];
}
@end
