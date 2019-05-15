//
//  TupmiuStickerView.h
//  Tupmiu of everyone
//
//  Created by tce_ on 2018/12/20.
//  Copyright © 2018年 xisedun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCEStickerView : UIView
- (instancetype)initWithFrame:(CGRect)frame withPaperImage:(UIImage *)paperImage;
- (BOOL)tce_isToolBarHidden;
- (void)tce_hideToolBar;
- (void)tce_showToolBar;
- (instancetype)copyWithScaleFactor:(CGFloat)factor relativedView:(UIView *)imageView;
@property (nonatomic, strong)UIImageView *tce_PaperImgView;
@end
