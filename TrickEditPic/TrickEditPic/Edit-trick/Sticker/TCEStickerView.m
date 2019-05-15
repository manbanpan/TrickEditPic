//
//  TupmiuStickerView.m
//  Tupmiu of everyone
//
//  Created by tce_ on 2018/12/20.
//  Copyright © 2018年 xisedun. All rights reserved.
//

#import "TCEStickerView.h"
#import <GLKit/GLKit.h>

#define tce_BorderViewWidth 80
#define tce_BtnWidth 30

#define tce_CloseImage @"clone_grbi-1"
#define tce_BrotationImage @"clone_xrvr-1"
#define tce_ScaleImage @"clone_ghda"

@interface TCEStickerView()
@property (nonatomic, strong)UIButton *tce_closeBtn;
@property (nonatomic, strong)UIButton *tce_flipBtn;
@property (nonatomic, strong)UIButton *tce_rotationBtn;
@property (nonatomic, strong)UIButton *tce_scaleBtn;

@property (nonatomic, strong)UIImage *tce_PaperImage;
@property (nonatomic, strong)UIView *tce_BorderView;

@property (nonatomic, assign)CGFloat tce_Ratio;
@property (nonatomic, assign)CGPoint tce_imageOffset;
@property (nonatomic, assign)BOOL tce_currentTooBarHidden;
@end
@implementation TCEStickerView

- (instancetype)initWithFrame:(CGRect)frame withPaperImage:(UIImage *)paperImage
{
    _tce_PaperImage = paperImage;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        size_t ww = CGImageGetWidth(_tce_PaperImage.CGImage);
        size_t hh = CGImageGetHeight(_tce_PaperImage.CGImage);
        _tce_Ratio = (float)ww/(float)hh;
        ww = tce_BorderViewWidth;
        hh = ww/_tce_Ratio;
        self.userInteractionEnabled = YES;
        [self daldkfasdfk:CGSizeMake(ww, hh)];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSArray *subviews = [[self.subviews reverseObjectEnumerator] allObjects];
    for (UIView *view in subviews) {
        if (view.userInteractionEnabled && CGRectContainsPoint(view.frame, point)) {
            return view;
        }
    }
    return nil;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    return YES;
}

#pragma mark -
#pragma mark - ---------------Action---------------
- (void)tce_hideToolBar;
{
    self.tce_closeBtn.hidden = YES;
    self.tce_flipBtn.hidden = YES;
    self.tce_scaleBtn.hidden = YES;
    self.tce_rotationBtn.hidden = YES;
    self.tce_BorderView.hidden = YES;
}
- (void)tce_showToolBar;
{
    self.tce_closeBtn.hidden = NO;
    self.tce_flipBtn.hidden = NO;
    self.tce_scaleBtn.hidden = NO;
    self.tce_rotationBtn.hidden = NO;
    self.tce_BorderView.hidden = NO;
}

- (BOOL)tce_isToolBarHidden
{
    return _tce_closeBtn.hidden && _tce_rotationBtn.hidden && _tce_scaleBtn.hidden && _tce_flipBtn.hidden;
}

- (void)tce_PaperImgViewPan:(UIPanGestureRecognizer*)gesture
{
    CGPoint gestureOrigin = [gesture locationInView:self.superview];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            _tce_currentTooBarHidden = [self tce_isToolBarHidden];
            _tce_imageOffset = CGPointMake(gestureOrigin.x-self.center.x, gestureOrigin.y-self.center.y);
            break;
        case UIGestureRecognizerStateChanged:
            [self tce_hideToolBar];
            self.center = CGPointMake(gestureOrigin.x-_tce_imageOffset.x, gestureOrigin.y-_tce_imageOffset.y);
            break;
        case UIGestureRecognizerStateEnded:
            if (!_tce_currentTooBarHidden) [self tce_showToolBar];
            _tce_imageOffset = CGPointZero;
            break;
            
        default:
            _tce_imageOffset = CGPointZero;
            break;
    }
}

- (void)tce_closeAction:(UIButton *)btn
{
    [self removeFromSuperview];
}

- (void)tce_flipAction:(UIButton *)btn
{
    self.tce_PaperImgView.transform = CGAffineTransformScale(self.tce_PaperImgView.transform, -1.0, 1.0);
}

- (void)tce_rotationAction:(UIPanGestureRecognizer *)pan
{
    CGPoint gestureOrigin = [pan locationInView:self];
    CGPoint center = self.tce_PaperImgView.center;
    
    GLKVector2 originVec = GLKVector2Normalize(GLKVector2Make(self.tce_rotationBtn.center.x - center.x, self.tce_rotationBtn.center.y - center.y));
    GLKVector2 newVec = GLKVector2Normalize(GLKVector2Make(gestureOrigin.x - center.x, gestureOrigin.y - center.y));
    
    CGFloat cos = GLKVector2DotProduct(originVec, newVec);
    CGFloat rad = MAX(MIN(acos(cos), 2*M_PI), 0);
    
    if (newVec.x > originVec.x) {
        rad = rad;
    }else {
        rad = -rad;
    }
    
    self.transform = CGAffineTransformRotate(self.transform, rad);
}

- (void)tce_scaleAction:(UIPanGestureRecognizer *)pan
{
    CGPoint gestureOrigin = [pan locationInView:self];
    
    gestureOrigin.x = gestureOrigin.x - tce_BtnWidth/2;
    gestureOrigin.y = gestureOrigin.y - tce_BtnWidth/2;
    
    CGFloat deltaX = gestureOrigin.x - self.tce_PaperImgView.center.x;
    CGFloat deltaY = gestureOrigin.y - self.tce_PaperImgView.center.y;
    
    CGFloat scaleX = deltaX/(self.tce_PaperImgView.frame.size.width/2);
    CGFloat scaleY = deltaY/(self.tce_PaperImgView.frame.size.height/2);
    scaleX = MAX(scaleX, 0);
    scaleY = MAX(scaleY, 0);
    
    if (scaleX < 1.0f && self.tce_PaperImgView.frame.size.width*scaleX <= tce_BtnWidth) {
        scaleX = tce_BtnWidth/self.tce_PaperImgView.frame.size.width;
    }
    
    if (scaleY < 1.0f && self.tce_PaperImgView.frame.size.height*scaleY <= tce_BtnWidth) {
        scaleY = tce_BtnWidth/self.tce_PaperImgView.frame.size.height;
    }
    
    self.tce_closeBtn.frame = CGRectMake(CGRectGetMinX(self.tce_PaperImgView.frame) - tce_BtnWidth + 8, CGRectGetMinY(self.tce_PaperImgView.frame) - tce_BtnWidth + 8, tce_BtnWidth, tce_BtnWidth);
    
    self.tce_flipBtn.frame = CGRectMake(CGRectGetMinX(self.tce_PaperImgView.frame) - tce_BtnWidth + 8, CGRectGetMaxY(self.tce_PaperImgView.frame) - 8, tce_BtnWidth, tce_BtnWidth);
    
    self.tce_rotationBtn.frame = CGRectMake(CGRectGetMaxX(self.tce_PaperImgView.frame) - 8, CGRectGetMinY(self.tce_PaperImgView.frame) - tce_BtnWidth + 8, tce_BtnWidth, tce_BtnWidth);
    
    self.tce_scaleBtn.frame = CGRectMake(CGRectGetMaxX(self.tce_PaperImgView.frame) - 8, CGRectGetMaxY(self.tce_PaperImgView.frame) - 8, tce_BtnWidth, tce_BtnWidth);
    
    // imageView
    self.tce_PaperImgView.transform = CGAffineTransformScale(self.tce_PaperImgView.transform, scaleX, scaleY);
    
    self.tce_BorderView.frame = self.tce_PaperImgView.frame;
    
}

- (void)daldkfasdfk:(CGSize)size
{
    [self dlkafdf:size];
}

- (void)dlkafdf:(CGSize)size
{
    [self sdflaksd:size];
}

- (void)sdflaksd:(CGSize)size
{
    [self sdfsakdf:size];
}

- (void)sdfsakdf:(CGSize)size
{
    [self tce_setBorderViewWithSize:size];
}

- (void)tce_setBorderViewWithSize:(CGSize)size
{
    self.tce_BorderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.tce_BorderView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.tce_BorderView.userInteractionEnabled = NO;
    self.tce_BorderView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tce_BorderView.layer.borderWidth = 1;
    self.tce_BorderView.layer.cornerRadius = 3;
    [self addSubview:self.tce_BorderView];
    
    self.tce_PaperImgView = [[UIImageView alloc] initWithFrame:self.tce_BorderView.frame];
    self.tce_PaperImgView.userInteractionEnabled = YES;
    [self.tce_PaperImgView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tce_PaperImgViewPan:)]];
    self.tce_PaperImgView.image = _tce_PaperImage;
    [self addSubview:self.tce_PaperImgView];
    
    self.tce_closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tce_closeBtn setImage:[UIImage imageNamed:tce_CloseImage] forState:UIControlStateNormal];
    [self.tce_closeBtn addTarget:self action:@selector(tce_closeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tce_closeBtn.frame = CGRectMake(CGRectGetMinX(self.tce_PaperImgView.frame) - tce_BtnWidth + 8, CGRectGetMinY(self.tce_PaperImgView.frame) - tce_BtnWidth + 8, tce_BtnWidth, tce_BtnWidth);
    [self addSubview:self.tce_closeBtn];
    
    self.tce_flipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tce_flipBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.tce_flipBtn addTarget:self action:@selector(tce_flipAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tce_flipBtn.frame = CGRectMake(CGRectGetMinX(self.tce_PaperImgView.frame) - tce_BtnWidth + 8, CGRectGetMaxY(self.tce_PaperImgView.frame) - 8, tce_BtnWidth, tce_BtnWidth);
    [self addSubview:self.tce_flipBtn];
    
    self.tce_rotationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tce_rotationBtn setImage:[UIImage imageNamed:tce_BrotationImage] forState:UIControlStateNormal];
    UIPanGestureRecognizer *panGestureRotate = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tce_rotationAction:)];
    [self.tce_rotationBtn addGestureRecognizer:panGestureRotate];
    self.tce_rotationBtn.frame = CGRectMake(CGRectGetMaxX(self.tce_PaperImgView.frame) - 8, CGRectGetMinY(self.tce_PaperImgView.frame) - tce_BtnWidth + 8, tce_BtnWidth, tce_BtnWidth);
    [self addSubview:self.tce_rotationBtn];

    self.tce_scaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tce_scaleBtn setImage:[UIImage imageNamed:tce_ScaleImage] forState:UIControlStateNormal];
    UIPanGestureRecognizer *panGestureSacle = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tce_scaleAction:)];
    [self.tce_scaleBtn addGestureRecognizer:panGestureSacle];
    self.tce_scaleBtn.frame = CGRectMake(CGRectGetMaxX(self.tce_PaperImgView.frame) - 8, CGRectGetMaxY(self.tce_PaperImgView.frame) - 8, tce_BtnWidth, tce_BtnWidth);
    [self addSubview:self.tce_scaleBtn];
    
}
#pragma mark -
#pragma mark - ---------------getter---------------
- (instancetype)copyWithScaleFactor:(CGFloat)factor relativedView:(UIView *)imageView
{
    TCEStickerView *stickerView = [[[self class] alloc] initWithFrame:[UIScreen mainScreen].bounds withPaperImage:self.tce_PaperImage];
    
    stickerView.transform = self.transform;
    
    stickerView.tce_PaperImgView.transform = CGAffineTransformScale(self.tce_PaperImgView.transform, 1.0f/factor, 1.0f/factor);

    CGFloat centerX = self.center.x - imageView.frame.origin.x;
    CGFloat centerY = self.center.y - imageView.frame.origin.y;
    stickerView.center = CGPointMake(centerX/factor, centerY/factor);
    
    return stickerView;
}

@end
