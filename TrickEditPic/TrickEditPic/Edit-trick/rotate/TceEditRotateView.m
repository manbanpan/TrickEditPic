//
//  TceEditRotateView.m
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditRotateView.h"
@interface TceEditRotateView()
@property (nonatomic,   weak)UIButton *tceEdit_btn;

@end

@implementation TceEditRotateView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupRotateView];
    }
    
    return self;
}

- (void)setupRotateView
{
    NSArray *icons_s = @[@"xuanzhuan-7-2",@"xuanzhuan-7-1",@"shangxia2",@"zouyou2"];
    NSArray *icons_n = @[@"xuanzhuan-7-0",@"xuanzhuan-7",@"shangxia2_2",@"zouyou2_2"];
    CGFloat www = 50;
    CGFloat hhh = 50;
    CGFloat space = 40;
    CGFloat gra = (self.frame.size.width - 2 * space - icons_n.count * www) / (icons_n.count - 1);
    for (int j = 0; j<icons_n.count; j++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:icons_n[j]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:icons_s[j]] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"img_cir_n"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tceEdit_barItem:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(space + (www + gra) * j,(self.frame.size.height - hhh)/2 , www, hhh);
        btn.tag = j + 8888;
        [self addSubview:btn];
    }
}

- (void)tceEdit_barItem:(UIButton *)btn
{
    if (self.rotateBlock) {
        self.rotateBlock(btn.tag - 8888);
    }
    btn.selected = YES;
    if (btn == self.tceEdit_btn) return;
    self.tceEdit_btn.selected = NO;
    self.tceEdit_btn = btn;
}

- (void)tceWileAllPhoto
{
    NSMutableArray *arr  = [NSMutableArray array];
    for (int i = 0 ; i < 55; i++) {
        NSString *str = [NSString stringWithFormat:@"tce_bobo_%d",i];
        UIImage *image = [UIImage imageNamed:str];
        if (image) {
            [arr addObject:image];
        }
    }
}

@end
