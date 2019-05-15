//
//  TceEditCuttingView.m
//  Picture Editing
//
//  Created by zzb on 2019/4/11.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditCuttingView.h"

static const NSUInteger kLeftTopCircleView = 1;
static const NSUInteger kLeftBottomCircleView = 2;
static const NSUInteger kRightTopCircleView = 3;
static const NSUInteger kRightBottomCircleView = 4;

@implementation TceEditCuttingView{
    TceEditGridLayer *_tceEditGridLayer;
    TceEditBtnCircle *_tceEditBtnlt;
    TceEditBtnCircle *_tceEditBtnrt;
    TceEditBtnCircle *_tceEditBtnlb;
    TceEditBtnCircle *_tceEditBtnrb;
    
}

- (id)initWithSuperview:(UIView*)superview frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [superview addSubview:self];
        _tceEditGridLayer = [[TceEditGridLayer alloc] init];
        _tceEditGridLayer.frame = self.bounds;
        _tceEditGridLayer.tceEdit_bgColor   = [UIColor colorWithWhite:1 alpha:0.6];
        _tceEditGridLayer.tceEdit_gridColor = [UIColor colorWithWhite:0 alpha:0.6];

        [self.layer addSublayer:_tceEditGridLayer];
        
        _tceEditBtnlt = [self tceEditBtnCircleWithTag:kLeftTopCircleView];
        _tceEditBtnrt = [self tceEditBtnCircleWithTag:kRightTopCircleView];
        _tceEditBtnlb = [self tceEditBtnCircleWithTag:kLeftBottomCircleView];
        _tceEditBtnrb = [self tceEditBtnCircleWithTag:kRightBottomCircleView];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tceEditPanCuttingView:)];
        [self addGestureRecognizer:panGesture];
        self.clippingRect = self.bounds;
    }
    return self;
}


- (TceEditBtnCircle*)tceEditBtnCircleWithTag:(NSInteger)tag
{
    TceEditBtnCircle *view = [[TceEditBtnCircle alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.tag = tag;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tceEditPanCircleView:)];
    [view addGestureRecognizer:panGesture];
    [self.superview addSubview:view];
    return view;
}

- (void)tceEditPanCircleView:(UIPanGestureRecognizer *)sender
{
//locationInView:获取到的是手指点击屏幕实时的坐标点；
//translationInView：获取到的是手指移动后，在相对坐标中的偏移量
    CGPoint point = [sender locationInView:self];
    CGPoint dp = [sender translationInView:self];
    
    CGRect rct = self.clippingRect;
    
    const CGFloat W = self.frame.size.width;
    const CGFloat H = self.frame.size.height;
    CGFloat minX = 0;
    CGFloat minY = 0;
    CGFloat maxX = W;
    CGFloat maxY = H;
    CGFloat ratio = (sender.view.tag == 1 || sender.view.tag==2) ? -self.tceEditCuttingRatio.ratio : self.tceEditCuttingRatio.ratio;
    switch (sender.view.tag) {
        case kLeftTopCircleView: //  left top
        {
            maxX = MAX((rct.origin.x + rct.size.width)  - 0.1 * W, 0.1 * W);
            maxY = MAX((rct.origin.y + rct.size.height) - 0.1 * H, 0.1 * H);
            
            if(ratio!=0){
                CGFloat y0 = rct.origin.y - ratio * rct.origin.x;
                CGFloat x0 = -y0 / ratio;
                minX = MAX(x0, 0);
                minY = MAX(y0, 0);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y > 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            }
            else{
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = rct.size.width  - (point.x - rct.origin.x);
            rct.size.height = rct.size.height - (point.y - rct.origin.y);
            rct.origin.x = point.x;
            rct.origin.y = point.y;
            break;
        }
        case kLeftBottomCircleView: //  left bottom
        {
            maxX = MAX((rct.origin.x + rct.size.width)  - 0.1 * W, 0.1 * W);
            minY = MAX(rct.origin.y + 0.1 * H, 0.1 * H);
            
            if(ratio!=0){
                CGFloat y0 = (rct.origin.y + rct.size.height) - ratio* rct.origin.x ;
                CGFloat xh = (H - y0) / ratio;
                minX = MAX(xh, 0);
                maxY = MIN(y0, H);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y < 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            }
            else{
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = rct.size.width  - (point.x - rct.origin.x);
            rct.size.height = point.y - rct.origin.y;
            rct.origin.x = point.x;
            break;
        }
        case kRightTopCircleView: // upper right
        {
            minX = MAX(rct.origin.x + 0.1 * W, 0.1 * W);
            maxY = MAX((rct.origin.y + rct.size.height) - 0.1 * H, 0.1 * H);
            
            if(ratio!=0){
                CGFloat y0 = rct.origin.y - ratio * (rct.origin.x + rct.size.width);
                CGFloat yw = ratio * W + y0;
                CGFloat x0 = -y0 / ratio;
                maxX = MIN(x0, W);
                minY = MAX(yw, 0);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y > 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            }
            else{
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = point.x - rct.origin.x;
            rct.size.height = rct.size.height - (point.y - rct.origin.y);
            rct.origin.y = point.y;
            break;
        }
        case kRightBottomCircleView: // lower right
        {
            minX = MAX(rct.origin.x + 0.1 * W, 0.1 * W);
            minY = MAX(rct.origin.y + 0.1 * H, 0.1 * H);
            
            if(ratio!=0){
                CGFloat y0 = (rct.origin.y + rct.size.height) - ratio * (rct.origin.x + rct.size.width);
                CGFloat yw = ratio * W + y0;
                CGFloat xh = (H - y0) / ratio;
                maxX = MIN(xh, W);
                maxY = MIN(yw, H);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y < 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            }
            else{
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = point.x - rct.origin.x;
            rct.size.height = point.y - rct.origin.y;
            break;
        }
        default:
            break;
    }
    self.clippingRect = rct;
}

- (void)tceEditPanCuttingView:(UIPanGestureRecognizer *)sender
{
    static BOOL dragging = NO;
    static CGRect initialRect;
    
    if(sender.state==UIGestureRecognizerStateBegan){
        CGPoint point = [sender locationInView:self];
        dragging = CGRectContainsPoint(_clippingRect, point);
        initialRect = self.clippingRect;
    }
    else if(dragging){
        CGPoint point = [sender translationInView:self];
        CGFloat left  = MIN(MAX(initialRect.origin.x + point.x, 0), self.frame.size.width-initialRect.size.width);
        CGFloat top   = MIN(MAX(initialRect.origin.y + point.y, 0), self.frame.size.height-initialRect.size.height);
        
        CGRect rct = self.clippingRect;
        rct.origin.x = left;
        rct.origin.y = top;
        self.clippingRect = rct;
    }
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [_tceEditBtnlb removeFromSuperview];
    [_tceEditBtnrb removeFromSuperview];
    [_tceEditBtnrt removeFromSuperview];
    [_tceEditBtnlt removeFromSuperview];
}

- (void)tceEditCuttingRatioChange
{
    CGRect rect = self.bounds;
    if(self.tceEditCuttingRatio){
        CGFloat H = rect.size.width * self.tceEditCuttingRatio.ratio;
        if(H<=rect.size.height){
            rect.size.height = H;
        }
        else{
            rect.size.width *= rect.size.height / H;
        }
        
        rect.origin.x = (self.bounds.size.width - rect.size.width) / 2;
        rect.origin.y = (self.bounds.size.height - rect.size.height) / 2;
    }
    [self setClippingRect:rect animated:YES];
}

- (void)setRatioDic:(NSDictionary *)ratioDic
{
    if (_ratioDic != ratioDic) {
        _ratioDic = ratioDic;
        
        if ([ratioDic[@"value1"] floatValue] == 0 && [ratioDic[@"value2"] floatValue] == 0)
        {
            self.tceEditCuttingRatio = nil;
        }else
        {
            self.tceEditCuttingRatio = [[TceEditRatio alloc] initWithValue1:[ratioDic[@"value1"] floatValue]  value2:[ratioDic[@"value2"] floatValue]];
        }
        
        [self tceEditCuttingRatioChange];
    }
}

- (void)setBgColor:(UIColor *)bgColor
{
    _tceEditGridLayer.tceEdit_bgColor = bgColor;
}

- (void)setGridColor:(UIColor *)gridColor
{
    _tceEditGridLayer.tceEdit_gridColor = gridColor;
}

- (void)setClippingRect:(CGRect)clippingRect
{
    _clippingRect = clippingRect;
    /*
     [viewC convertRect:viewB.frame fromView:viewA];
     该例子viewA是源，viewB是被操作的对象，那么viewC就是目标。作用就是计算viewA上的viewB相对于viewC的frame。
     */
    _tceEditBtnlt.center = [self.superview convertPoint:CGPointMake(_clippingRect.origin.x, _clippingRect.origin.y) fromView:self];
    _tceEditBtnrt.center = [self.superview convertPoint:CGPointMake(_clippingRect.origin.x + _clippingRect.size.width, _clippingRect.origin.y) fromView:self];
    _tceEditBtnlb.center = [self.superview convertPoint:CGPointMake(_clippingRect.origin.x, _clippingRect.origin.y + _clippingRect.size.height) fromView:self];
    _tceEditBtnrb.center = [self.superview convertPoint:CGPointMake(_clippingRect.origin.x + _clippingRect.size.width, _clippingRect.origin.y + _clippingRect.size.height) fromView:self];
    _tceEditGridLayer.tceEdit_rect = clippingRect;
    [self setNeedsDisplay];
}

- (void)setClippingRect:(CGRect)clippingRect animated:(BOOL)animated
{
    if(animated){
        [UIView animateWithDuration:0.25
                         animations:^{
                             self->_tceEditBtnlt.center = [self.superview convertPoint:CGPointMake(clippingRect.origin.x, clippingRect.origin.y) fromView:self];
                             self->_tceEditBtnlb.center = [self.superview convertPoint:CGPointMake(clippingRect.origin.x, clippingRect.origin.y+clippingRect.size.height) fromView:self];
                             self->_tceEditBtnrt.center = [self.superview convertPoint:CGPointMake(clippingRect.origin.x+clippingRect.size.width, clippingRect.origin.y) fromView:self];
                             self->_tceEditBtnrb.center = [self.superview convertPoint:CGPointMake(clippingRect.origin.x+clippingRect.size.width, clippingRect.origin.y+clippingRect.size.height) fromView:self];
                         }
         ];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"clippingRect"];
        animation.duration = 0.25;
        animation.fromValue = [NSValue valueWithCGRect:_clippingRect];
        animation.toValue = [NSValue valueWithCGRect:clippingRect];
        [_tceEditGridLayer addAnimation:animation forKey:nil];
        
        _tceEditGridLayer.tceEdit_rect = clippingRect;
        _clippingRect = clippingRect;
        [self setNeedsDisplay];
    }
    else{
        self.clippingRect = clippingRect;
    }
}


- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [_tceEditGridLayer setNeedsDisplay];
}
@end


#pragma mark - 四角按钮
@implementation TceEditBtnCircle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rct = self.bounds;
    rct.origin.x = rct.size.width/2-rct.size.width/6;
    rct.origin.y = rct.size.height/2-rct.size.height/6;
    rct.size.width /= 3;
    rct.size.height /= 3;
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(context, rct);
}

@end

#pragma mark - 网格layer
@implementation TceEditGridLayer

- (instancetype)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer]) {
        self.tceEdit_rect = ((TceEditGridLayer *)layer).tceEdit_rect;
        self.tceEdit_bgColor = ((TceEditGridLayer *)layer).tceEdit_bgColor;
        self.tceEdit_gridColor = ((TceEditGridLayer *)layer).tceEdit_gridColor;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)context
{
    CGRect rct = self.bounds;
    CGContextSetFillColorWithColor(context, self.tceEdit_bgColor.CGColor);
    CGContextFillRect(context, rct);
    
    CGContextClearRect(context, _tceEdit_rect);
    
    CGContextSetStrokeColorWithColor(context, self.tceEdit_gridColor.CGColor);
    CGContextSetLineWidth(context, 1);
    
    rct = self.tceEdit_rect;
    
    CGContextBeginPath(context);
    CGFloat dW = 0;
    for(int i=0;i<4;++i){
        CGContextMoveToPoint(context, rct.origin.x+dW, rct.origin.y);
        CGContextAddLineToPoint(context, rct.origin.x+dW, rct.origin.y+rct.size.height);
        dW += _tceEdit_rect.size.width/3;
    }
    
    dW = 0;
    for(int i=0;i<4;++i){
        CGContextMoveToPoint(context, rct.origin.x, rct.origin.y+dW);
        CGContextAddLineToPoint(context, rct.origin.x+rct.size.width, rct.origin.y+dW);
        dW += rct.size.height/3;
    }
    CGContextStrokePath(context);
}

@end

#pragma mark - 比例
@implementation TceEditRatio
{
    CGFloat _longSide;
    CGFloat _shortSide;
}

- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2
{
    self = [super init];
    if(self){
        _longSide  = MAX(fabs(value1), fabs(value2));
        _shortSide = MIN(fabs(value1), fabs(value2));
    }
    return self;
}

- (CGFloat)ratio
{
    if(_longSide==0 || _shortSide==0){
        return 0;
    }
    
    if(self.isLandscape){
        return _shortSide / (CGFloat)_longSide;
    }
    return _longSide / (CGFloat)_shortSide;
}

@end
