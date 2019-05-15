//
//  TCEPuzzleStyleView.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPuzzleStyleView.h"
#import "TcePuzzleViewFrameAndPoint.h"
@interface TCEPuzzleStyleView()

@property (nonatomic, strong)NSArray *images ;
@property (nonatomic, strong)NSMutableArray *picLocks ;

@end
@implementation TCEPuzzleStyleView

- (instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images
{
    self.images = images;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.picLocks = [NSMutableArray array];
        [self tceSetupStyleView];
    }
    
    return self;
}

- (void)tceSetupStyleView
{
    NSArray *icon = [TcePuzzleViewFrameAndPoint tceGetArrayWithQuantity:self.images.count];
    UIScrollView *bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,15/2 , tceSW, 50)];
    bgView.showsVerticalScrollIndicator = NO;
    bgView.showsHorizontalScrollIndicator = NO;
    [self addSubview:bgView];
    CGFloat space = (tceSW - 6 * 50 - 20)/5;
    bgView.contentSize = CGSizeMake(10 + (50 + space) * icon.count, 50);
    [self.picLocks removeAllObjects];
    for (int i = 0; i<icon.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 5;
        NSString *str = [NSString stringWithFormat:@"style_%ld_%d",self.images.count,i];
        [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tceSelectStyle:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(10 + (50 + space) * i, 0, 50, 50);
        btn.tag = i + 3000;
        [bgView addSubview:btn];
    }
}

- (void)tceSelectStyle:(UIButton *)btn
{
    if ([self.delegates respondsToSelector:@selector(tceStyleView:didStyle:)]) {
        [self.delegates tceStyleView:self didStyle:btn.tag - 3000];
    }
}

@end
