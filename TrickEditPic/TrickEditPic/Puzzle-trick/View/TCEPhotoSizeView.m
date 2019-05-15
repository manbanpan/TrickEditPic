//
//  TCEPhotoSizeView.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPhotoSizeView.h"
@interface TCEPhotoSizeView()

@property (nonatomic, strong)NSArray *tceRatios ;

@property (nonatomic,   weak)UIButton *tceBrigeBtn;

@end

@implementation TCEPhotoSizeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self tceSetupSizeView];
    }
    
    return self;
}

- (void)tceSetupSizeView
{
    NSArray *icons_n = @[@"Normal",@"1:1",@"3:4",@"2:1",@"4:3",@"5:7"];
    self.tceRatios = @[@(292/392.0),@(1.0),@(3/4.0),@(2.0),@(4/3.0),@(5/7.0)];
    UIScrollView *barScrollView = [[UIScrollView alloc] init];
    [self addSubview:barScrollView];
    [barScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(@(tceRX(50)));
    }];
    CGFloat www = tceRX(50);
    CGFloat hhh = tceRX(50);
    CGFloat space = 20;
    CGFloat gra = (self.frame.size.width - 2 * space - icons_n.count * www) / (icons_n.count - 1);
    barScrollView.contentSize = CGSizeMake(2 * space + icons_n.count * www + (icons_n.count - 1) *gra, self.frame.size.height);
    for (int i = 0; i<icons_n.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:icons_n[i] forState:UIControlStateNormal];
        [btn setTitle:icons_n[i] forState:UIControlStateSelected];
        [btn setTitleColor:TCEWhite forState:UIControlStateNormal];
        [btn setTitleColor:rgba(89, 211, 254, 1) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(tceSelectSize:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(space + (www + gra) * i, 0, www, hhh);
        btn.tag = i + 8888;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = TCEWhite.CGColor;
        btn.layer.borderWidth = 2;
        [barScrollView addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            self.tceBrigeBtn = btn;
        }
    }
}

- (void)tceSelectSize:(UIButton *)btn
{
    if ([self.delegates respondsToSelector:@selector(tceSizeView:didSelectRatio:)]) {
        [self.delegates tceSizeView:self didSelectRatio:[self.tceRatios[btn.tag - 8888] floatValue]];
    }
    self.tceBrigeBtn.selected = NO;
    btn.selected = YES;
    self.tceBrigeBtn = btn;
}
@end
