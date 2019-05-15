//
//  TceEditAdjustView.m
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditAdjustView.h"
@interface TceEditAdjustView()
@property (nonatomic,   weak)UIScrollView *tceEdit_scrollView;
@property (nonatomic,   weak)UISlider *tceEdit_slider;
@property (nonatomic, strong)UIView *tceEdit_sliderView ;
@property (nonatomic, strong)NSMutableArray *tceEdit_values;
@property (nonatomic, assign)NSInteger tceEdit_item;
@property (nonatomic, strong)NSArray *tceIcons_s;


@end

@implementation TceEditAdjustView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupAdjustView];
    }
    
    return self;
}

- (void)setupAdjustView
{
    self.tceIcons_s = @[@"taiyang-3",@"duibi-6",@"wenduji-2",@"baohedu-3",@"img_circle_s"];
    NSArray *icons_n = @[@"taiyang-4",@"duibi-7",@"wenduji-3",@"baohedu-4",@"img_circle_n"];
    UIScrollView *barScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.tceEdit_scrollView = barScrollView;
    [self addSubview:barScrollView];
    
    CGFloat www = 50;
    CGFloat hhh = 50;
    CGFloat space = 20;
    CGFloat gra = (self.frame.size.width - 2 * space - icons_n.count * www) / (icons_n.count - 1);
    barScrollView.contentSize = CGSizeMake(2 * space + icons_n.count * www + (icons_n.count - 1) *gra, self.frame.size.height);
    for (int i = 0; i<icons_n.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:icons_n[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.tceIcons_s[i]] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"img_cir_n"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tceEdit_barItem:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(space + (www + gra) * i, (self.frame.size.height - hhh)/2, www, hhh);
        btn.tag = i + 8888;
        [barScrollView addSubview:btn];
    }
}


- (UIView *)tceEdit_sliderView
{
    if (!_tceEdit_sliderView){
        _tceEdit_sliderView = [[UIView alloc] initWithFrame:self.bounds];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30, (self.frame.size.height - 50)/2, 50, 50);
        [btn addTarget:self action:@selector(tceEdit_hidden) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 8000;
        [_tceEdit_sliderView addSubview:btn];
        UISlider *slider = [[UISlider alloc] init];
        self.tceEdit_slider = slider;
        slider.frame = CGRectMake(90, (self.frame.size.height - 30)/2, (self.frame.size.width - 90 - 40), 30);
        slider.minimumTrackTintColor = [UIColor colorWithRed:181/255.0 green:79/255.0 blue:251/255.0 alpha:1];
        slider.maximumTrackTintColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [slider setThumbImage:[UIImage imageNamed:@"img_slider_cir"] forState:UIControlStateNormal];
        [slider addTarget:self action:@selector(tceEdit_sliderValue:) forControlEvents:UIControlEventValueChanged];
        [_tceEdit_sliderView addSubview:slider];
        [self addSubview:_tceEdit_sliderView];
    }
    return _tceEdit_sliderView;
}


- (NSMutableArray *)tceEdit_values
{
    if (!_tceEdit_values){
        _tceEdit_values = [NSMutableArray array];
        NSArray *arr  = @[@0.0 , @1.0, @1.0, @5000,  @0,      ];
        NSArray *mins = @[@(-1), @0.0, @0.0, @1000,  @(-4.0), ];
        NSArray *maxs = @[@1.0 , @4.0, @2.0, @10000, @4.0,    ];
        
        for (int i = 0; i<arr.count; i++)
        {
            TceEditAdjustModel *model = [[TceEditAdjustModel alloc] init];
            model.minValue = [mins[i] floatValue] * 100;
            model.Value = [arr[i] floatValue] * 100;
            model.maxValue = [maxs[i] floatValue] * 100;
            [_tceEdit_values addObject:model];
        }
    }
    return _tceEdit_values;
}

- (void)tceEdit_sliderValue:(UISlider *)slider
{
    NSLog(@"%f",slider.value);
    if (self.adjustBlock) {
        self.adjustBlock(slider.value/100.0,self.tceEdit_item);
    }
}



- (void)tceEdit_barItem:(UIButton *)btn
{
    self.tceEdit_scrollView.hidden = YES;
    self.tceEdit_sliderView.hidden = NO;
    self.tceEdit_item = btn.tag - 8888;
    TceEditAdjustModel *model = self.tceEdit_values[btn.tag - 8888];
    self.tceEdit_slider.minimumValue = model.minValue;
    self.tceEdit_slider.maximumValue = model.maxValue;
    self.tceEdit_slider.value = model.Value;
    UIButton *button = (UIButton *)[self.tceEdit_sliderView viewWithTag:8000];
    [button setImage:tceImaged(self.tceIcons_s[btn.tag - 8888]) forState:UIControlStateNormal];
}

- (void)tceEdit_hidden
{
    self.tceEdit_scrollView.hidden = NO;
    self.tceEdit_sliderView.hidden = YES;
    if (self.adjustSuccesBlock) {
        self.adjustSuccesBlock();
    }
}

@end



@implementation TceEditAdjustModel

@end


/***********************************************************/
@implementation DSMagnifierView

- (void)dealloc {
    NSLog(@"DSMagnifierView dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        //为了居于状态条之上
        self.windowLevel = UIWindowLevelStatusBar + 1;
        self.layer.delegate = self;
        //保证和屏幕读取像素的比例一致
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //提前位移半个长宽的坑
    CGContextTranslateCTM(ctx, self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGContextScaleCTM(ctx, 1.5, 1.5);
    //再次位移后就可以把触摸点移至self.center的位置
    CGContextTranslateCTM(ctx, -1 * self.renderPoint.x, -1 * self.renderPoint.y);
    
    [self.renderView.layer renderInContext:ctx];
}

#pragma mark - setter and getter
- (void)setRenderPoint:(CGPoint)renderPoint {
    _renderPoint = renderPoint;
    
    [self.layer setNeedsDisplay];
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    self.layer.borderColor = hidden ? [[UIColor clearColor] CGColor] : [[UIColor lightGrayColor] CGColor];
}

@end
