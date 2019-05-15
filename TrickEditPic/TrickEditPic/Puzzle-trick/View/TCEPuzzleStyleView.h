//
//  TCEPuzzleStyleView.h
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TCEPuzzleStyleView;
@protocol TCEPuzzleStyleViewDelegate <NSObject>
@required

- (void)tceStyleView:(TCEPuzzleStyleView *)styleView didStyle:(NSInteger) tag;

@end

@interface TCEPuzzleStyleView : UIView

@property (nonatomic,   weak)id<TCEPuzzleStyleViewDelegate> delegates;

- (instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images;
@end

NS_ASSUME_NONNULL_END
