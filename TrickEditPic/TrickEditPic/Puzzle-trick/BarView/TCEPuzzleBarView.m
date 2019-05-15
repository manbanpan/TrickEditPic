//
//  TCEPuzzleBarView.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPuzzleBarView.h"

@implementation TCEPuzzleBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self tceSetupView];
    }
    return self;
}

- (void)tceSetupView
{
    self.backgroundColor = rgba(15, 15, 15, 1);
    NSArray *icons_n = @[@"tt_ratio",@"ttt_border",@"ttt_puzzle_bg",@"ttt_edit_edit"];
    UIScrollView *barScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:barScrollView];
    
    CGFloat www = 50;
    CGFloat hhh = 50;
    CGFloat space = 20;
    CGFloat gra = (self.frame.size.width - 2 * space - icons_n.count * www) / (icons_n.count - 1);
    barScrollView.contentSize = CGSizeMake(2 * space + icons_n.count * www + (icons_n.count - 1) *gra, self.frame.size.height);
    for (int i = 0; i<icons_n.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:icons_n[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:icons_n[i]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(tceEdit_barItem:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(space + (www + gra) * i, 0, www, hhh);
        btn.tag = i + 8888;
        [barScrollView addSubview:btn];
    }
    UIView *lineView = [UIView new];
    lineView.backgroundColor = rgba(175, 175, 175,0.5);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

- (void)tceEdit_barItem:(UIButton *)btn
{
    if ([self.barDelegate respondsToSelector:@selector(puzzleBar:didSelectItem:)]) {
        [self.barDelegate puzzleBar:self didSelectItem:btn];
    }
}
@end
