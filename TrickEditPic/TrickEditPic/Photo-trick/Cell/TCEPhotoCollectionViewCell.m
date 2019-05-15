//
//  TCEPhotoCollectionViewCell.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPhotoCollectionViewCell.h"

@implementation TCEPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tceContentImg.contentMode = UIViewContentModeScaleAspectFill;
    self.tceContentImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected
{
    
}

-(void)tceButtonAnimation:(UIButton *)button{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [button.layer addAnimation:animation forKey:nil];
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    self.tceIndentyBtn.selected = isSelect;
    self.tceIndentyView.hidden = !isSelect;
}
@end
