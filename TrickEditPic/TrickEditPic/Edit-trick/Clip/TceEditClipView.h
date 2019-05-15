//
//  TceEditClipView.h
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TceEditClipView : UIView
@property (nonatomic,   copy)void(^clipBlock) (NSDictionary *dic);

@end
