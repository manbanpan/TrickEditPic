//
//  TCEPhotoCollectionViewCell.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCEPhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tceContentImg;
@property (weak, nonatomic) IBOutlet UIView *tceIndentyView;
@property (weak, nonatomic) IBOutlet UIButton *tceIndentyBtn;
@property (nonatomic, assign) BOOL isSelect;
-(void)tceButtonAnimation:(UIButton *)button;
@end

NS_ASSUME_NONNULL_END
