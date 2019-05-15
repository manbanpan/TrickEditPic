//
//  TCEPuzzleViewController.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPuzzleViewController.h"
#import "TCEPuzzleBarView.h"
#import "TcePuzzlePuzzleView.h"
#import "TcePuzzlePuzzleEditScrollView.h"
#import "TCEPhotoFrameView.h"
#import "TCEPuzzleStyleView.h"
#import "TCEPuzzleBgView.h"
#import "TCEPhotoSizeView.h"
#import "TcePuzzleViewFrameAndPoint.h"

@interface TCEPuzzleViewController ()
<TCEPuzzleBarViewDelegate,TCEPhotoFrameViewDelegate,TCEPuzzleStyleViewDelegate,TCEPuzzleBgViewDelegate,TCEPhotoSizeViewDelegate>
@property (nonatomic, strong)TCEPuzzleBarView *tceBarView ;
@property (nonatomic, strong)UIButton *tceNavRightBtn;

@property (nonatomic, strong) TcePuzzlePuzzleView  *tcePuzzleView;
@property (nonatomic, strong) TCEPhotoFrameView *tcePhotoFrameView ;
@property (nonatomic, strong) TCEPuzzleStyleView *tcePuzzleStyleView ;
@property (nonatomic, strong) TCEPuzzleBgView *tcePuzzleBgView;
@property (nonatomic, strong) TCEPhotoSizeView *tcePhotoSizeView ;



@end

@implementation TCEPuzzleViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tcePuzzleView setTcePuzzleStyleIndex:self.tceImages.count];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tceSetNavView];
    [self tceSetupView];
//    NSString *homeDir = NSHomeDirectory();
//    NSLog(@"homeDir = %@",homeDir);
//    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    //在这里,我们指定搜索的是Cache目录,所以结果只有一个,取出Cache目录
//    NSString *cachePath = array[0];
//    
//    //拼接文件路径
//    NSString *filePathName = [cachePath stringByAppendingPathComponent:@"agePlist.plist"];
//    [[TcePuzzleViewFrameAndPoint tceGetArrayWithQuantity:4] writeToFile:filePathName atomically:YES];
//    NSLog(@"%@",cachePath);
}

- (void)tceSetupView
{
    self.title = @"Puzzle";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tceBarView];
    [self.view addSubview:self.tcePuzzleView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(tceRestoreLocation) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, tceSW, tceSH - tceNavH - tceBarH - 49 - tceRY(80));
    [self.view insertSubview:btn belowSubview:self.tcePuzzleView];
    
}

- (void)tceSetNavView
{
    self.tceNavRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tceNavRightBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateSelected];
    [self.tceNavRightBtn setImage:[UIImage imageNamed:@"baocun1"] forState:UIControlStateNormal];
    [self.tceNavRightBtn addTarget:self action:@selector(tceEdit_saveToPhoto:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.tceNavRightBtn];
}
#pragma mark - TCEPuzzleBarViewDelegate
- (void)puzzleBar:(TCEPuzzleBarView *)barView didSelectItem:(UIButton *)btn
{
    [self tceHiddenAllTools];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.tcePuzzleView.center = CGPointMake(tceSW/2, (tceSH - tceNavH - tceBarH - 49 - tceRY(80))/2);
    }];
    
    switch (btn.tag) {
        case 8888:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tcePhotoSizeView.y = tceSH - tceNavH - tceBarH - 49 - tceRY(80);
            }];
        }
            break;
        case 8889:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tcePhotoFrameView.y = tceSH - tceNavH - tceBarH - 49 - tceRY(80);
            }];
        }
            break;
        case 8890:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tcePuzzleBgView.y = tceSH - tceNavH - tceBarH - 49 - tceRY(80);
            }];
        }
            break;
        case 8891:{
            [UIView animateWithDuration:0.25 animations:^{
                self.tcePuzzleStyleView.y = tceSH - tceNavH - tceBarH - 49 - tceRY(80);
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - delegate
- (void)tcePuzzleBgView:(TCEPuzzleBgView *)frameView didSelectImg:(UIImage *)image
{
    self.tcePuzzleView.tceImage = image;
}

- (void)tceStyleView:(TCEPuzzleStyleView *)styleView didStyle:(NSInteger)tag
{
    [self.tcePuzzleView setTcePuzzleStyleRow:tag];
}

- (void)tceFrameView:(TCEPhotoFrameView *)frameView didGraValue:(CGFloat)value
{
    self.tcePuzzleView.grpValue = value;
}

- (void)tceFrameView:(TCEPhotoFrameView *)frameView didBorderValue:(CGFloat)value;
{
    self.tcePuzzleView.borderValue = value;
}

- (void)tceSizeView:(TCEPhotoSizeView *)sizeView didSelectRatio:(CGFloat)ratio;
{
    [self.tcePuzzleView removeFromSuperview];
    self.tcePuzzleView = nil;
    
    self.tcePuzzleView.frame = CGRectMake(0, 0, tceSW - tceRX(60), (tceSW - tceRX(60))/ratio);
    self.tcePuzzleView.center = CGPointMake(tceSW/2, (tceSH - tceNavH - tceBarH - 49 - tceRY(80))/2);
    [self.tcePuzzleView setTcePuzzleStyleIndex:self.tceImages.count];
}

#pragma mark - action
- (void)tceEdit_saveToPhoto:(UIButton *)add
{
    UIImage *image = [self.tcePuzzleView TCEGetImageWithFrame:self.tcePuzzleView.bounds];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        if (success)
        {
            [SVProgressHUD showSuccessWithStatus:@"Save Success"];
        }
    }];
}

- (void)tceHiddenAllTools
{
    if (_tcePuzzleStyleView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tcePuzzleStyleView.y = tceSH;
        }];
    }
    if (_tcePhotoFrameView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tcePhotoFrameView.y = tceSH;
        }];
    }
    if (_tcePuzzleBgView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tcePuzzleBgView.y = tceSH;
        }];
    }
    
    if (_tcePhotoSizeView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tcePhotoSizeView.y = tceSH;
        }];
    }
}

- (void)tceRestoreLocation
{
    [self tceHiddenAllTools];
    [UIView animateWithDuration:0.25 animations:^{
        self.tcePuzzleView.center = CGPointMake(tceSW/2, (tceSH - tceNavH - tceBarH - 49)/2);
    }];
}

#pragma mark - lazy

- (TCEPuzzleBarView *)tceBarView
{
    if (!_tceBarView){
        _tceBarView = [[TCEPuzzleBarView alloc] initWithFrame:CGRectMake(0, tceSH - tceBarH - 49 - tceNavH, tceSW, 49)];
        _tceBarView.barDelegate = self;
    }
    return _tceBarView;
}


- (TcePuzzlePuzzleView *)tcePuzzleView
{
    if (!_tcePuzzleView){
        CGFloat scale = 292/392.0;
        _tcePuzzleView = [[TcePuzzlePuzzleView alloc] initWithFrame:CGRectMake(0, 0, tceSW - tceRX(60), (tceSW - tceRX(60))/scale)];
        _tcePuzzleView.center = CGPointMake(tceSW/2, (tceSH - tceNavH - tceBarH - 49)/2);
        _tcePuzzleView.TcePuzzleAssetArray = self.tceImages;
        [self.view addSubview:_tcePuzzleView];
    }
    return _tcePuzzleView;
}


- (TCEPhotoFrameView *)tcePhotoFrameView
{
    if (!_tcePhotoFrameView){
        _tcePhotoFrameView = [[TCEPhotoFrameView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, tceRY(80))];
        _tcePhotoFrameView.delegates = self;
        [self.view insertSubview:_tcePhotoFrameView belowSubview:self.tceBarView];
    }
    return _tcePhotoFrameView;
}


- (TCEPuzzleStyleView *)tcePuzzleStyleView
{
    if (!_tcePuzzleStyleView){
        _tcePuzzleStyleView = [[TCEPuzzleStyleView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, tceRY(80)) withImages:self.tceImages];
        _tcePuzzleStyleView.delegates = self;
        [self.view insertSubview:_tcePuzzleStyleView belowSubview:self.tceBarView];
    }
    return _tcePuzzleStyleView;
}


- (TCEPuzzleBgView *)tcePuzzleBgView
{
    if (!_tcePuzzleBgView){
        _tcePuzzleBgView = [[TCEPuzzleBgView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, tceRY(80))];
        _tcePuzzleBgView.delegates = self;
        [self.view insertSubview:_tcePuzzleBgView belowSubview:self.tceBarView];
    }
    return _tcePuzzleBgView;
}


- (TCEPhotoSizeView *)tcePhotoSizeView
{
    if (!_tcePhotoSizeView){
        _tcePhotoSizeView = [[TCEPhotoSizeView alloc] initWithFrame:CGRectMake(0, tceSH, tceSW, tceRY(80))];
        _tcePhotoSizeView.delegates = self;
        [self.view insertSubview:_tcePhotoSizeView belowSubview:self.tceBarView];
    }
    return _tcePhotoSizeView;
}


@end
