//
//  TCEPuzzleBgView.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCEPuzzleBgView;
@protocol TCEPuzzleBgViewDelegate <NSObject>
@required

- (void)tcePuzzleBgView:(TCEPuzzleBgView *)frameView didSelectImg:(UIImage *)image;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TCEPuzzleBgView : UIView

@property (nonatomic,   weak)id<TCEPuzzleBgViewDelegate> delegates;

@end

NS_ASSUME_NONNULL_END


@interface TCEPuzzleBgCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *tceImageView ;


@end
