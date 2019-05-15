//
//  TceEditEditViewController.m
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditEditViewController.h"
#import "TceEditTabBarView.h"
#import "TceEditFilterView.h"
#import "TceEditRotateView.h"
#import "TceEditAdjustView.h"
#import "TceEditClipView.h"
#import "TceEditAdjustManager.h"
#import "GPUImage.h"
#import "TceEditCuttingView.h"
#import "TceEditAllFilterManager.h"
#import "TceEditBorderView.h"
#import "TCEEditStickerView.h"
#import "TCEStickerView.h"
@interface TceEditEditViewController ()
<TceEditTabBarViewDelegate>
@property (nonatomic, strong)TceEditTabBarView *tceEditTabBarView ;
@property (nonatomic, strong)TceEditFilterView *tceEditFilterView ;
@property (nonatomic, strong)TceEditRotateView *tceEditRotateView ;
@property (nonatomic, strong)TceEditAdjustView *tceEditAdjustView ;
@property (nonatomic, strong)TceEditBorderView *tceEditBorderView ;
@property (nonatomic, strong)TceEditClipView *tceEditClipView ;
@property (nonatomic, strong)TceEditCuttingView *tceEditCuttingView ;
@property (nonatomic, strong)TCEEditStickerView *tceEditStickerView ;


@property (nonatomic, strong)UIImageView *tceEditNeedEditView ;
@property (nonatomic, strong)UIImageView *tceEditBorderImgView ;

@property (nonatomic, strong)GPUImageView *tceEditGPUImgView ;
@property (nonatomic, strong)UIImage *tceEditSourceImg ;
@property (nonatomic, strong)UIButton *tceNavRightBtn ;
@property (nonatomic, strong)UIButton *tceDismissBtn;




@end

@implementation TceEditEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tceEdit_setNav];
    [self tceEdit_InitView];
}

- (void)tceEdit_saveToPhoto:(UIButton *)add
{
    if (add.selected) {
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            //1,保存图片到系统相册
            [PHAssetChangeRequest creationRequestForAssetFromImage:self.tceEditNeedEditView.image];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (success)
            {
                [SVProgressHUD showSuccessWithStatus:@"Save Success"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            NSLog(@"保存成功");
        }];
    }else
    {
        if (_tceEditCuttingView) {
            self.tceEditNeedEditView.image = [self tceEdit_newImageWithClip];
        }
        if (_tceEditBorderView) {
            self.tceEditNeedEditView.image = [self tceEdit_newImageWithBorder];
        }
        if (_tceEditStickerView) {
            self.tceEditNeedEditView.image = [self tceEdit_newImageWithSticker];
        }
        self.needEditImg = self.tceEditNeedEditView.image;
        self.tceEditSourceImg = self.tceEditNeedEditView.image;
        [self tceEditHidden];
        
        add.selected = YES;
    }
    
    
   
}

- (void)tceEditNeedEditViewAction:(UITapGestureRecognizer *)tap
{
    if (_tceEditStickerView) {
        NSArray *subviews = [[self.tceEditNeedEditView.subviews reverseObjectEnumerator] allObjects];
        for (UIView *view in subviews) {
            if ([view isKindOfClass:[TCEStickerView class]]) {
                TCEStickerView *dragView = (id)view;
                CGPoint location = [tap locationInView:view];
                if (view.userInteractionEnabled && CGRectContainsPoint(dragView.tce_PaperImgView.frame, location)) {
                    if ([(id)view tce_isToolBarHidden]) {
                        [(id)view tce_showToolBar];
                    }else {
                        [(id)view tce_hideToolBar];
                    }
                }else {
                    [(id)view tce_hideToolBar];
                }
            }
        }
    }else
    {
        [self tceEdit_closeCurrentTools];
    }
    
}

- (void)tceEdit_closeCurrentTools
{
    self.needEditImg = self.tceEditSourceImg;
    self.tceEditNeedEditView.image = self.tceEditSourceImg;
    [self tceEditHidden];
}

- (void)tceEditHidden
{
    CGRect oldRect = CGRectMake(15, 15, tceSW - 30, tceSH - tceBarH - tceNavH - 50 - 30);
    CGSize newSize = [self tceEdit_getNewSize:oldRect.size];
    CGRect newRect = CGRectMake((tceSW - newSize.width)/2, 15 + (tceSH - tceBarH - tceNavH - 50 - 30 - newSize.height)/2, newSize.width, newSize.height);
    if (_tceEditFilterView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tceEditFilterView.y = tceSH;
            self.tceEditNeedEditView.frame = newRect;
        }];
    }
    if (_tceEditRotateView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tceEditRotateView.y = tceSH;
            self.tceEditNeedEditView.frame = newRect;
        }];
    }
    if (_tceEditAdjustView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tceEditAdjustView.y = tceSH;
            self.tceEditNeedEditView.frame = newRect;
        }];
    }
    if (_tceEditClipView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tceEditClipView.y = tceSH;
            self.tceEditNeedEditView.frame = newRect;
            [self tceEdit_removeCuttingView];
        }];
    }
    if (_tceEditBorderView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tceEditBorderView.y = tceSH;
            self.tceEditNeedEditView.frame = newRect;
            [self.tceEditBorderImgView removeFromSuperview];
            self.tceEditBorderImgView = nil;
        }];
    }
    if (_tceEditStickerView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tceEditStickerView.y = tceSH;
            self.tceEditNeedEditView.frame = newRect;
            [self tceEdit_removeStickerView];
        }];
    }
}

- (UIImage *)tceEdit_newImageWithBorder
{
    UIImage *img = self.tceEditNeedEditView.image;
    CGImageRef imgRef = img.CGImage;
    CGFloat w = CGImageGetWidth(imgRef);
    CGFloat h = CGImageGetHeight(imgRef);
    
    //以1.png的图大小为底图
    UIImage *img1 = self.tceEditBorderImgView.image;
    
    //以1.png的图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(w, h));
    [img drawInRect:CGRectMake(0, 0, w, h)];//先把1.png 画到上下文中
    [img1 drawInRect:CGRectMake(0, 0, w, h)];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    
    return resultImg;
}

#pragma mark - 裁剪
- (UIImage *)tceEdit_newImageWithClip
{
    CGFloat zoomScale = self.tceEditNeedEditView.width / self.tceEditNeedEditView.image.size.width;
    CGRect rct = self.tceEditCuttingView.clippingRect;
    rct.size.width  /= zoomScale;
    rct.size.height /= zoomScale;
    rct.origin.x    /= zoomScale;
    rct.origin.y    /= zoomScale;
    [self tceEdit_removeCuttingView];
    return  [self.tceEditNeedEditView.image crop:rct];
}

- (void)tceEdit_removeCuttingView
{
    [self.tceEditCuttingView removeFromSuperview];
    self.tceEditCuttingView = nil;
}

#pragma mark - sticker

- (UIImage *)tceEdit_newImageWithSticker
{
    CGFloat scaleX  = self.tceEditNeedEditView.frame.size.width/CGImageGetWidth(self.needEditImg.CGImage);
    CGFloat scaleY  = self.tceEditNeedEditView.frame.size.height/CGImageGetHeight(self.needEditImg.CGImage);
    CGFloat scaleFactor = MIN(scaleX, scaleY);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.needEditImg];
    for (UIView *view in self.tceEditNeedEditView.subviews)
    {
        if ([view isKindOfClass:[TCEStickerView class]])
        {
            TCEStickerView *papaerView = [(TCEStickerView *)view copyWithScaleFactor:scaleFactor relativedView:self.tceEditNeedEditView];
            [papaerView tce_hideToolBar];
            [imageView addSubview:papaerView];
            [view removeFromSuperview];
        }
    }
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [imageView.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)tceEdit_removeStickerView
{
    for (UIView *view in self.tceEditNeedEditView.subviews)
    {
        if ([view isKindOfClass:[TCEStickerView class]])
        {
            [view removeFromSuperview];
        }
    }
    
    [self.tceEditStickerView removeFromSuperview];
    self.tceEditStickerView = nil;
}
#pragma mark - TceEditTabBarViewDelegate
- (void)TceEditTabBarView:(TceEditTabBarView *)barView selectBarItem:(UIButton *)item
{
    [self tceEditHidden];
    CGSize newSize = [self tceEdit_getNewSize:CGSizeMake(tceSW - 30, tceSH - tceBarH - tceNavH - 50 - 30 - 65)];
    [UIView animateWithDuration:0.25 animations:^{
        self.tceEditNeedEditView.frame = CGRectMake((tceSW - newSize.width)/2, 15 + (tceSH - tceBarH - tceNavH - 50 - 30 - 65 - newSize.height)/2, newSize.width, newSize.height);
    }];
    CGFloat yy = tceSH - tceNavH - tceBarH - 50 - 65;
    switch (item.tag - 8888) {
        case 0:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tceEditFilterView.y = yy;
            }];
        }
            break;
        case 1:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tceEditClipView.y = yy;
            }completion:^(BOOL finished) {
                self.tceEditCuttingView.hidden = NO;
            }];
        }
            break;
        case 2:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tceEditBorderView.y = yy;
            }completion:^(BOOL finished) {
                self.tceEditBorderImgView.hidden = NO;
            }];
        }
            break;
        case 3:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tceEditAdjustView.y = yy;
            }];
        }
            break;
        case 4:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tceEditRotateView.y = yy;
            }];
        }
            break;
        case 5:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tceEditStickerView.y = yy;
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - block
- (void)tceEdit_rotateBlock
{
    self.tceNavRightBtn.selected = NO;
    __block UIImage *oldImage = self.tceEditNeedEditView.image;
    __block UIImage *newImage;
    tceWeak(self);
    self.tceEditRotateView.rotateBlock = ^(NSInteger item) {
        switch (item) {
            case 0:
                newImage = [oldImage imageByRotate:M_PI_2 fitSize:YES];
                oldImage = newImage;
                weakSelf.tceEditNeedEditView.image = newImage;
                break;
                
            case 1:
                newImage = [oldImage imageByRotate:-M_PI_2 fitSize:YES];
                oldImage = newImage;
                weakSelf.tceEditNeedEditView.image = newImage;
                break;
                
            case 2:
                weakSelf.tceEditNeedEditView.transform = CGAffineTransformScale(weakSelf.tceEditNeedEditView.transform, -1.0, -1.0);
                break;
                
            case 3:
                weakSelf.tceEditNeedEditView.transform = CGAffineTransformScale(weakSelf.tceEditNeedEditView.transform, -1.0, 1.0);
                break;
                
            default:
                break;
        }
    };
    
}

- (void)tceEdit_adjustBlock
{
    self.tceNavRightBtn.selected = NO;
    __block UIImage *newImage;
    tceWeak(self);
    self.tceEditAdjustView.adjustBlock = ^(CGFloat value, NSInteger item) {
        switch (item) {
            case 0:
                newImage = [TceEditAdjustManager tceEdit_changeValueForBrightness:value image:weakSelf.needEditImg];
                break;
            case 1:
                newImage = [TceEditAdjustManager tceEdit_changeValueForContrast:value image:weakSelf.needEditImg];
                break;
                
            case 2:
                newImage = [TceEditAdjustManager tceEdit_changeValueForSaturation:value image:weakSelf.needEditImg];
                
                break;
                
            case 3:
                newImage = [TceEditAdjustManager tceEdit_changeValueForWhiteBalance:value image:weakSelf.needEditImg];
                
                break;
                
            case 4:
                newImage = [TceEditAdjustManager tceEdit_changeValueForSharpen:value image:weakSelf.needEditImg];
                
                break;
            default:
                break;
        }
        weakSelf.tceEditNeedEditView.image = newImage;
    };
    
    self.tceEditAdjustView.adjustSuccesBlock = ^{
        weakSelf.needEditImg = weakSelf.tceEditNeedEditView.image;
    };
}

- (void)tceEdit_clipBlock
{
    tceWeak(self);
    self.tceNavRightBtn.selected = NO;
    self.tceEditClipView.clipBlock = ^(NSDictionary *dic) {
        weakSelf.tceEditCuttingView.ratioDic = dic;
    };
}

- (void)tceEditFilterBlock
{
    tceWeak(self);
    self.tceNavRightBtn.selected = NO;
    self.tceEditFilterView.filterBlock = ^(NSInteger item) {
      weakSelf.tceEditNeedEditView.image = [TceEditAllFilterManager tceEdit_newImageWithItem:item oldImage:weakSelf.needEditImg];
    };
}

- (void)tceEdit_borderBlock
{
    tceWeak(self);
    self.tceNavRightBtn.selected = NO;
    self.tceEditBorderView.borderBlock = ^(UIImage *image) {
        weakSelf.tceEditBorderImgView.image = image;
    };
}

- (void)tceEdit_stickerBlock
{
    tceWeak(self);
    self.tceNavRightBtn.selected = NO;
    self.tceEditStickerView.tceStickerBlock = ^(UIImage * _Nonnull image) {
        for (UIView *view in weakSelf.tceEditNeedEditView.subviews) {
            if ([view isKindOfClass:[TCEStickerView class]])
            {
                [(TCEStickerView *)view tce_hideToolBar];
            }
        }
        TCEStickerView *paperView = [[TCEStickerView alloc] initWithFrame:weakSelf.tceEditNeedEditView.frame withPaperImage:image];
        [weakSelf.tceEditNeedEditView addSubview:paperView];
    };
}

#pragma mark - Init
- (void)tceEdit_setNav
{
    self.title = @"Edit";
    self.tceNavRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tceNavRightBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateSelected];
    [self.tceNavRightBtn setImage:[UIImage imageNamed:@"baocun1"] forState:UIControlStateNormal];
    [self.tceNavRightBtn addTarget:self action:@selector(tceEdit_saveToPhoto:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.tceNavRightBtn];
}

- (void)tceEdit_InitView
{
    self.tceEditSourceImg = self.needEditImg;
    self.tceEditNeedEditView.image = self.needEditImg;
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tceDismissBtn];
    [self.view addSubview:self.tceEditTabBarView];
    [self.view addSubview:self.tceEditNeedEditView];
    
}

#pragma mark - get
- (TceEditTabBarView *)tceEditTabBarView
{
    if (!_tceEditTabBarView){
        _tceEditTabBarView = [[TceEditTabBarView alloc] initWithFrame:CGRectMake(0, tceSH - tceBarH - tceNavH - 50, tceSW, 50)];
        _tceEditTabBarView.delegate = self;
    }
    return _tceEditTabBarView;
}


- (TceEditFilterView *)tceEditFilterView
{
    if (!_tceEditFilterView){
        _tceEditFilterView = [[TceEditFilterView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, 65)];
        [self tceEditFilterBlock];
        [self.view insertSubview:_tceEditFilterView belowSubview:self.tceEditTabBarView];
    }
    return _tceEditFilterView;
}


- (TceEditRotateView *)tceEditRotateView
{
    if (!_tceEditRotateView){
        _tceEditRotateView = [[TceEditRotateView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, 65)];
        [self tceEdit_rotateBlock];
        [self.view insertSubview:_tceEditRotateView belowSubview:self.tceEditTabBarView];
    }
    return _tceEditRotateView;
}


- (TceEditAdjustView *)tceEditAdjustView
{
    if (!_tceEditAdjustView){
        _tceEditAdjustView = [[TceEditAdjustView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, 65)];
        [self tceEdit_adjustBlock];
        [self.view insertSubview:_tceEditAdjustView belowSubview:self.tceEditTabBarView];
    }
    return _tceEditAdjustView;
}


- (TceEditBorderView *)tceEditBorderView
{
    if (!_tceEditBorderView){
        _tceEditBorderView = [[TceEditBorderView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, 65)];
        [self tceEdit_borderBlock];
        [self.view insertSubview:_tceEditBorderView belowSubview:self.tceEditTabBarView];
    }
    return _tceEditBorderView;
}


- (TceEditClipView *)tceEditClipView
{
    if (!_tceEditClipView){
        _tceEditClipView = [[TceEditClipView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, 65)];
        [self tceEdit_clipBlock];
        [self.view insertSubview:_tceEditClipView belowSubview:self.tceEditTabBarView];
    }
    return _tceEditClipView;
}


- (TceEditCuttingView *)tceEditCuttingView
{
    if (!_tceEditCuttingView){
        _tceEditCuttingView = [[TceEditCuttingView alloc] initWithSuperview:self.tceEditNeedEditView.superview frame:self.tceEditNeedEditView.frame];
        _tceEditCuttingView.backgroundColor = [UIColor clearColor];
        _tceEditCuttingView.bgColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        _tceEditCuttingView.gridColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        _tceEditCuttingView.clipsToBounds = NO;
    }
    return _tceEditCuttingView;
}


- (TCEEditStickerView *)tceEditStickerView
{
    if (!_tceEditStickerView){
        _tceEditStickerView = [[TCEEditStickerView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, 65)];
        [self tceEdit_stickerBlock];
        [self.view insertSubview:_tceEditStickerView belowSubview:self.tceEditTabBarView];
    }
    return _tceEditStickerView;
}



- (UIImageView  *)tceEditNeedEditView
{
    if (!_tceEditNeedEditView){
        _tceEditNeedEditView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, tceSW - 30, tceSH - tceBarH - tceNavH - 50 - 30)];
        _tceEditNeedEditView.contentMode = UIViewContentModeScaleAspectFit;
        _tceEditNeedEditView.userInteractionEnabled = YES;
        [_tceEditNeedEditView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tceEditNeedEditViewAction:)]];
    }
    return _tceEditNeedEditView;
}


- (UIImageView *)tceEditBorderImgView
{
    if (!_tceEditBorderImgView){
        _tceEditBorderImgView = [[UIImageView alloc] initWithFrame:self.tceEditNeedEditView.frame];
        _tceEditBorderImgView.image = [UIImage imageNamed:@"1"];
        [self.view addSubview:_tceEditBorderImgView];
    }
    return _tceEditBorderImgView;
}


- (UIButton *)tceDismissBtn
{
    if (!_tceDismissBtn){
        _tceDismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tceDismissBtn addTarget:self action:@selector(tceEdit_closeCurrentTools) forControlEvents:UIControlEventTouchUpInside];
        _tceDismissBtn.frame = CGRectMake(0, 0, tceSW, tceSH - tceNavH - tceBarH - tceRY(115));
        [self.view addSubview:_tceDismissBtn];
    }
    return _tceDismissBtn;
}


- (CGSize)tceEdit_getNewSize:(CGSize)size
{
    size_t ww = CGImageGetWidth(self.needEditImg.CGImage);
    size_t hh = CGImageGetHeight(self.needEditImg.CGImage);
    CGFloat scaleX = size.width/ww;
    CGFloat scaleY = size.height/hh;
    CGFloat scale  = MIN(scaleX, scaleY);
    return CGSizeMake(ww *scale, hh *scale);
}

@end
