//
//  TCEPhotoFrameView.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPhotoFrameView.h"

@implementation TCEPhotoFrameView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self tceSetupFrameView];
    }
    
    return self;
}

- (void)tceSetupFrameView
{
    UIView *graView = [[UIView alloc] init];
    UIView *borderView = [[UIView alloc] init];
    
    [self addSubview:graView];
    [self addSubview:borderView];
    
    [graView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(borderView.mas_top);
    }];
    
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(graView.mas_height);
    }];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"suofang-2"] forState:UIControlStateNormal];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"yuanjiao"] forState:UIControlStateNormal];
    
    [graView addSubview:btn];
    [borderView addSubview:btn2];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(graView).offset(tceRX(30));
        make.centerY.equalTo(graView);
        make.width.height.equalTo(@30);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(borderView).offset(tceRX(30));
        make.centerY.equalTo(borderView);
        make.width.height.equalTo(@30);
    }];
    
    UISlider *slider1 = [self tceGetSliderWithImage:@"ttt_slider_circle" minColor:rgba(254, 183, 16, 1)];
    [slider1 addTarget:self action:@selector(tceGraSliderValue:) forControlEvents:UIControlEventValueChanged];
    
    UISlider *slider2 = [self tceGetSliderWithImage:@"ttt_slider_circle2" minColor:rgba(92, 217, 255, 1)];
    [slider2 addTarget:self action:@selector(tceBorderSliderValue:) forControlEvents:UIControlEventValueChanged];
    
    [graView addSubview:slider1];
    [borderView addSubview:slider2];
    
    [slider1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(graView);
        make.left.equalTo(btn.mas_right).offset(tceRX(15));
        make.right.equalTo(graView).offset(-tceRX(40));
    }];
    
    [slider2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(borderView);
        make.left.equalTo(btn2.mas_right).offset(tceRX(15));
        make.right.equalTo(borderView).offset(-tceRX(40));
    }];
}

- (UISlider *)tceGetSliderWithImage:(NSString *)imgStr minColor:(UIColor *)color
{
    UISlider *slider = [[UISlider alloc] init];
    slider.minimumTrackTintColor = color;
    slider.maximumTrackTintColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [slider setThumbImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    slider.value = 0;
    slider.maximumValue = 15;
    slider.minimumValue = 0;
    return slider;
}

- (void)tceGraSliderValue:(UISlider *)slider
{
    if ([self.delegates respondsToSelector:@selector(tceFrameView:didGraValue:)]) {
        [self.delegates tceFrameView:self didGraValue:slider.value];
    }
}

- (void)tceBorderSliderValue:(UISlider *)slider
{
    if ([self.delegates respondsToSelector:@selector(tceFrameView:didBorderValue:)]) {
        [self.delegates tceFrameView:self didBorderValue:slider.value];
    }
}

@end
