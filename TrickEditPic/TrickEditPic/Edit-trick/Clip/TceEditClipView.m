//
//  TceEditClipView.m
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditClipView.h"
@interface TceEditClipView()
@property (nonatomic, strong)NSArray *tceEdit_ratios ;
@property (nonatomic,   weak)UIButton *tceBrigeBtn;

@end

@implementation TceEditClipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupClipView];
    }
    
    return self;
}

- (void)setupClipView
{
    NSArray *names = @[@"Free",@"1:1",@"3:4",@"2:3",@"9:16"];
    
    UIScrollView *barScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:barScrollView];
    
    CGFloat www = 50;
    CGFloat hhh = 50;
    CGFloat space = 20;
    CGFloat gra = (self.frame.size.width - 2 * space - names.count * www) / (names.count - 1);
    barScrollView.contentSize = CGSizeMake(2 * space + names.count * www + (names.count - 1) *gra, self.frame.size.height);
    for (int i = 0; i<names.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:names[i] forState:UIControlStateNormal];
        [btn setTitle:names[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:rgba(252, 173, 15, 1) forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"img_cir_n"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tceEdit_barItem:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(space + (www + gra) * i, (self.frame.size.height - hhh)/2, www, hhh);
        btn.tag = i + 8888;
        if (i == 0) {
            btn.selected = YES;
            self.tceBrigeBtn = btn;
        }
        [barScrollView addSubview:btn];
    }
}


- (NSArray *)tceEdit_ratios
{
    if (!_tceEdit_ratios){
        _tceEdit_ratios = @[@{
                            @"value1" : @0,
                            @"value2" : @0
                            },
                        @{
                            @"value1" : @1,
                            @"value2" : @1
                            },
                        @{
                            @"value1" : @3,
                            @"value2" : @4
                            },
                        @{
                            @"value1" : @2,
                            @"value2" : @3
                            },
                        @{
                            @"value1" : @9,
                            @"value2" : @16
                            }
                        ];
    }
    return _tceEdit_ratios;
}


- (void)tceEdit_barItem:(UIButton *)btn
{
    self.tceBrigeBtn.selected = NO;
    btn.selected = YES;
    if (self.clipBlock) {
        self.clipBlock(self.tceEdit_ratios[btn.tag - 8888]);
    }
    
    self.tceBrigeBtn = btn;
}

@end
