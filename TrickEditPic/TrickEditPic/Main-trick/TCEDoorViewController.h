//
//  TCEDoorViewController.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCEDoorViewController : UIViewController

@property (nonatomic,   copy)void(^doorBlock) (void);

@end

NS_ASSUME_NONNULL_END
