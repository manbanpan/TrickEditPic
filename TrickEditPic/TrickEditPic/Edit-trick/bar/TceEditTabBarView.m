//
//  TceEditTabBarView.m
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditTabBarView.h"

@implementation TceEditTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = rgba(11, 11, 11, 1);
        [self setupTabBarView];
    }
    
    return self;
}

- (void)setupTabBarView
{
    NSArray *icons_n = @[@"ttt_filter",@"tt_ratio",@"ttt_border",@"ttt_edit_edit",@"ttt_circle",@"ttt_sticker"];
    
    UIScrollView *barScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:barScrollView];
    
    CGFloat www = 50;
    CGFloat hhh = 50;
    CGFloat space = 20;
    CGFloat gra = (self.frame.size.width - 2 * space - 5 * www) / (5 - 1);
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
    if ([self.delegate respondsToSelector:@selector(TceEditTabBarView:selectBarItem:)]) {
        [self.delegate TceEditTabBarView:self selectBarItem:btn];
    }
}
@end
