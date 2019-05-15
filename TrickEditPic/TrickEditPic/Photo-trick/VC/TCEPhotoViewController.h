//
//  TCEPhotoViewController.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.

#import <UIKit/UIKit.h>
#import "TCEPhotoPublic.h"


NS_ASSUME_NONNULL_BEGIN

@interface TCEPhotoViewController : UIViewController

@property (nonatomic, assign) PhotoType photoType;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic,   copy) NSString  *tceTitle;


@end

NS_ASSUME_NONNULL_END
