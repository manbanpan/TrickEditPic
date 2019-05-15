//
//  TCEPuzzleBarView.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TCEPuzzleBarView;
@protocol TCEPuzzleBarViewDelegate <NSObject>

- (void)puzzleBar:(TCEPuzzleBarView *)barView didSelectItem:(UIButton *)btn;

@end

@interface TCEPuzzleBarView : UIView
@property (nonatomic,   weak)id<TCEPuzzleBarViewDelegate> barDelegate;

@end

NS_ASSUME_NONNULL_END
