//
//  TceEditBorderView.h
//  Picture Editing
//
//  Created by zzb on 2019/4/12.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TceEditBorderView : UIView
@property (nonatomic,   copy)void(^borderBlock) (UIImage *image);

@end
