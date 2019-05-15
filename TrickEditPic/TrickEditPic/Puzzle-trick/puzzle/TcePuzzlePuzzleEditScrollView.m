//
//  TcePuzzlePuzzleEditScrollView.m
//  ConstellationCamera
//
//  Created by zzb on 2019/1/9.
//  Copyright © 2019年 ConstellationCamera. All rights reserved.
//

#import "TcePuzzlePuzzleEditScrollView.h"
@interface TcePuzzlePuzzleEditScrollView()<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView  *TcePuzzleContentScrollView;
@end

@implementation TcePuzzlePuzzleEditScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self TcePuzzleInitEditView];
    }
    return self;
}

- (void)TcePuzzleInitEditView
{
    self.backgroundColor = [UIColor clearColor];

    _TcePuzzleContentScrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
    _TcePuzzleContentScrollView.delegate = self;
    _TcePuzzleContentScrollView.showsHorizontalScrollIndicator = NO;
    _TcePuzzleContentScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_TcePuzzleContentScrollView];
    
    self.TcePuzzleImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.TcePuzzleImageView.frame = CGRectMake(0, 0, tceSW * 2.5, tceSW * 2.5);
    self.TcePuzzleImageView.userInteractionEnabled = YES;
    [_TcePuzzleContentScrollView addSubview:self.TcePuzzleImageView];
    
     UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TcePuzzleHandleDoubleTap:)];
    doubleTap.numberOfTouchesRequired = 2;
    [self.TcePuzzleImageView addGestureRecognizer: doubleTap];
    
    //设置scrollview 放大缩小倍率
    float minimumScale = self.frame.size.width / self.TcePuzzleImageView.frame.size.width;
    [_TcePuzzleContentScrollView setMinimumZoomScale:minimumScale];
    [_TcePuzzleContentScrollView setZoomScale:minimumScale];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _TcePuzzleContentScrollView.frame = CGRectInset(self.bounds, 0, 0);
    self.TcePuzzleImageView.frame = CGRectMake(0, 0, tceSW * 2.5, tceSW * 2.5);
    float minimumScale = self.frame.size.width / self.TcePuzzleImageView.frame.size.width;
    [_TcePuzzleContentScrollView setMinimumZoomScale:minimumScale];
    [_TcePuzzleContentScrollView setZoomScale:minimumScale];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    _TcePuzzleContentScrollView.frame = CGRectInset(self.bounds, 0, 0);
    self.TcePuzzleImageView.frame = CGRectMake(0, 0, tceSW * 2.5, tceSW * 2.5);
    float minimumScale = self.frame.size.width / self.TcePuzzleImageView.frame.size.width;
    [_TcePuzzleContentScrollView setMinimumZoomScale:minimumScale];
    [_TcePuzzleContentScrollView setZoomScale:minimumScale];
}

- (void)setNotReloadFrame:(CGRect)frame;
{
    [super setFrame:frame];
}

- (void)setImageViewData:(UIImage *)image
{
    self.TcePuzzleImageView.image= image;
    if (image == nil) return;
    CGRect  rect  = CGRectZero;
    CGFloat scale = 1.0f;
    CGFloat w = 0.0f;
    CGFloat h = 0.0f;
    if(self.TcePuzzleContentScrollView.frame.size.width > self.TcePuzzleContentScrollView.frame.size.height)
    {
        
        w = self.TcePuzzleContentScrollView.frame.size.width;
        h = w * image.size.height / image.size.width;
        if(h < self.TcePuzzleContentScrollView.frame.size.height)
        {
            h = self.TcePuzzleContentScrollView.frame.size.height;
            w = h * image.size.width / image.size.height;
        }
        
    }else{
        
        h = self.TcePuzzleContentScrollView.frame.size.height;
        w = h * image.size.width / image.size.height;
        if(w < self.TcePuzzleContentScrollView.frame.size.width)
        {
            w = self.TcePuzzleContentScrollView.frame.size.width;
            h = w * image.size.height / image.size.width;
        }
    }
    rect.size = CGSizeMake(w, h);
    
//    CGFloat scale_w = w / image.size.width;
//    CGFloat scale_h = h / image.size.height;
//
//    if (w > self.frame.size.width || h > self.frame.size.height)
//    {
//        scale_w = w / self.frame.size.width;
//        scale_h = h / self.frame.size.height;
//        if (scale_w > scale_h)
//        {
//            scale = 1/scale_w;
//        }else{
//            scale = 1/scale_h;
//        }
//    }
//
//    if (w <= self.frame.size.width || h <= self.frame.size.height)
//    {
//        scale_w = w / self.frame.size.width;
//        scale_h = h / self.frame.size.height;
//        if (scale_w > scale_h)
//        {
//            scale = scale_h;
//        }else{
//            scale = scale_w;
//        }
//    }
//
    @synchronized(self){
        self.TcePuzzleImageView.frame = rect;
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = self.TcePuzzleRealCellPath.CGPath;
        maskLayer.fillColor = [[UIColor whiteColor] CGColor];
        maskLayer.frame = self.TcePuzzleImageView.frame;
        self.layer.mask = maskLayer;
//        [_TcePuzzleContentScrollView setZoomScale:0.2 animated:YES];
        [self setNeedsLayout];
    }
}

- (void)setImageViewData:(UIImage *)image rect:(CGRect)rect
{
    self.frame = rect;
    [self setImageViewData:image];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL contained=[self.TcePuzzleRealCellPath containsPoint:point];
    if ([self.editDelegate respondsToSelector:@selector(TcePuzzleTapWithEditView:)])
    {
        [self.editDelegate TcePuzzleTapWithEditView:nil];
    }
    return contained;
}

//双击放大
- (void)TcePuzzleHandleDoubleTap:(UITapGestureRecognizer *)tap
{
    float newScale = _TcePuzzleContentScrollView.zoomScale * 1.2;
    CGRect zoomRect = [self TcePuzzleZoomRectForScale:newScale withCenter:[tap locationInView:self.TcePuzzleImageView]];
    //zoomRect: 给定矩形的大小进行缩放
    [_TcePuzzleContentScrollView zoomToRect:zoomRect animated:YES];
}

//某点为中心放大
- (CGRect)TcePuzzleZoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    if (scale == 0)
    {
        scale = 1;
    }
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.TcePuzzleImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    //setZoomScale：animated 根据比例缩放
    [scrollView setZoomScale:scale animated:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touch = [[touches anyObject] locationInView:self.superview];
    self.TcePuzzleImageView.center = touch;
    
}
@end

/******************************************************************/
@implementation TSMneuLabel

- (void)setGestureType:(TSMneuLabelGestureType)gestureType{
    
    //移除所有手势
    for (UIGestureRecognizer *ges in self.gestureRecognizers) {
        [self removeGestureRecognizer:ges];
    }
    
    switch (gestureType) {
        case TSMneuLabelGestureTypeTap: {
            
            UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            touch.numberOfTapsRequired = 1;
            [self addGestureRecognizer:touch];
        }
            break;
        case TSMneuLabelGestureTypeLongTap: {
            
            UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [self addGestureRecognizer:touch];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - Init
+ (instancetype)mneuLabelWithMenuType:(TSMneuLabelMenuType)menuType
                       andGestureType:(TSMneuLabelGestureType)gestureType{
    
    return  [[self alloc]initWithMenuType:menuType andGestureType:gestureType];
}

- (instancetype)initWithMenuType:(TSMneuLabelMenuType)menuType
                  andGestureType:(TSMneuLabelGestureType)gestureType{
    
    return [self initWithFrame:CGRectZero andMenuType:menuType andGestureType:gestureType];
}

- (instancetype)initWithFrame:(CGRect)frame
                  andMenuType:(TSMneuLabelMenuType)menuType
               andGestureType:(TSMneuLabelGestureType)gestureType{
    
    if (self = [self initWithFrame:frame]) {
        
        self.menuType = menuType;
        self.gestureType = gestureType;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 * 让label可以响应用户操作
 */
- (void)setup{
    self.userInteractionEnabled = YES;
    
    if(self.gestureType == TSMneuLabelGestureTypeDefault){
        //如果是没有选择
        self.gestureType = TSMneuLabelGestureTypeTap;
    }
    
}

-(void)handleTap:(UIGestureRecognizer*) recognizer{
    //是当前的对象成为第一响应者
    [self becomeFirstResponder];
    
    //创建UIMenuController的控件
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO];
    switch (self.menuType) {
        case TSMneuLabelTypeDefault:{
            //默认不加
        }
            break;
        case TSMneuLabelTypeCopy:{
            //加复制
            [menu setMenuItems:@[]];
        }
            break;
        case TSMneuLabelTypeDemo:{
            
            UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"abc" action:@selector(flag:)];
            UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"Approve" action:@selector(approve:)];
            UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(deny:)];
            [menu setMenuItems:@[approve,flag,deny]];
            
        }
            break;
            
        default:
            break;
    }
    
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark - Action

- (void)copy:(id)sender {
    NSLog(@"copy");
    [UIPasteboard generalPasteboard].string = self.text?self.text:@"";
    NSLog(@"%@",self.text);
}

- (void)flag:(id)sender {
    NSLog(@"国旗");
}

- (void)approve:(id)sender {
    NSLog(@"Approve");
}

- (void)deny:(id)sender {
    NSLog(@"Deny");
}

#pragma mark - System
/**
 * 让label有资格成为第一响应者
 */
- (BOOL)canBecomeFirstResponder{
    return YES;
}

/**
 * label能执行哪些操作(比如copy, paste等等)
 * @return  YES:支持这种操作
 *  由于这里需要实现自定义的中文菜单，而不是使用默认的，所以这里选择NO
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    //这里也是间接影响显示在UIMenuController的控件
    if (action == @selector(copy:)) {
        return YES;//如果要去掉 拷贝 这里返回NO
    }else if (action == @selector(flag:)){
        return NO;//这里如果是no 就不允许操作和显示
    }else if (action == @selector(approve:)){
        return YES;
    }else if (action == @selector(deny:)){
        return YES;
    }else{
        return [super canPerformAction:action withSender:sender];
    }
}
@end
