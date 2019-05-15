//
//  TCEPhotoViewController.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPhotoViewController.h"
#import "TCEPhotoCollectionViewCell.h"
#import "TCEPhotoManager.h"
#import "TceEditEditViewController.h"
#import "TCEPuzzleViewController.h"
@interface TCEPhotoViewController ()
<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *tcePhotoCollectionView;
@property (nonatomic, strong) UIView *tceSelectPhotoView;
@property (nonatomic, strong) NSMutableArray *tceAllPhotos;
@property (nonatomic, strong) NSMutableArray *tceChoosePhotos;
@property (nonatomic, strong) NSMutableArray *tceChooseCells;
@property (nonatomic, strong) NSMutableArray *tceSelectViews ;
@property (nonatomic, strong) UIImageView *tceSelectImgView;
@property (nonatomic, strong) UIScrollView *tceSelectScrollView ;

@property (nonatomic, strong) PHCachingImageManager *tcePHCachManager ;


@end

@implementation TCEPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tceSetupView];
    [self tceGetAllPhoto];
    
}

- (void)tceSetupView
{
    self.title = self.tceTitle;
    self.maxCount = 5;
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat SelectToolH = kTCERY(143);
    [self.view addSubview:self.tcePhotoCollectionView];
    if (self.photoType == PhotoMoreType)
    {
        [self.view addSubview:self.tceSelectPhotoView];
        [self.tceSelectPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kTCEBarH);
            make.height.equalTo(@(SelectToolH));
        }];
        
        [self.tcePhotoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.tceSelectPhotoView.mas_top);
        }];
    }else
    {
        [self.tcePhotoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
}

#pragma mark - action
- (void)tceGetAllPhoto
{
    [TCEPhotoManager tceGetAllPhoto:^(PHFetchResult * _Nonnull result) {
        
        _tcePHCachManager = [[PHCachingImageManager alloc]init];
        
        for (PHAsset *asset in result) {
            if (asset.mediaType == PHAssetMediaTypeImage) {
                [self.tceAllPhotos addObject:asset];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tcePhotoCollectionView reloadData];
        });
        
    }];
}

- (void)tceSelectPhotoList:(PHAsset *)asset count:(NSInteger)count
{
    CGFloat www = kTCERY(95);
    [_tcePHCachManager requestImageForAsset:asset targetSize:CGSizeMake(kTCERY(75), kTCERY(75)) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        CGFloat gra = 0;
        
        if (count * www > TCE_kScreenWidth) {
            gra = (count + 1) * www - TCE_kScreenWidth;
            [self.tceSelectScrollView setContentOffset:CGPointMake(gra, 0) animated:YES];
        }
        
        UIView *view = [self tceCreateViewWithFrame:CGRectMake(TCE_kScreenWidth + gra, 0, www, www) Image:result tag:count];
        [self.tceSelectScrollView addSubview:view];
        self.tceSelectScrollView.contentSize = CGSizeMake((count + 1) * www, 0);
        [UIView animateWithDuration:0.25 animations:^{
            view.x = count * www;
        }];
    }];
}



- (UIView *)tceCreateViewWithFrame:(CGRect)frame Image:(UIImage *)image tag:(NSInteger)tag
{
    CGFloat www = kTCERY(75);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.frame = CGRectMake((view.frame.size.width - www)/2 , (view.frame.size.height - www)/2, www, www);
    [view addSubview:imgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.cornerRadius = kTCERX(20)/2;
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:@"ttt_close3"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tceRemovePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [self.tceSelectViews addObject:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgView.mas_top);
        make.centerX.equalTo(imgView.mas_left);
        make.width.height.equalTo(@(kTCERX(20)));
    }];
    return view;
}

- (void)tceRemovePhoto:(UIButton *)btn
{
    NSLog(@"btn---tag---%ld",btn.tag);
    NSIndexPath *indexPath = self.tceChooseCells[btn.tag];
    TCEPhotoCollectionViewCell *cell =(TCEPhotoCollectionViewCell *)[self.tcePhotoCollectionView cellForItemAtIndexPath:indexPath];
    cell.isSelect = NO;
    [self.tceChooseCells removeObjectAtIndex:btn.tag];
    [self.tceChoosePhotos removeObjectAtIndex:btn.tag];
    [self tceRemovePhotoWithTag:btn.tag];
}

- (void)tceRemovePhotoWithTag:(NSInteger)tag
{
    UIButton *selectBtn = self.tceSelectViews[tag];
    [selectBtn.superview removeFromSuperview];
    for (UIButton *unSelectBtn in self.tceSelectViews) {
        if (unSelectBtn.tag > selectBtn.tag) {
            unSelectBtn.tag = unSelectBtn.tag - 1;
            UIView *unSelectView = unSelectBtn.superview;
            CGRect oldFrame = unSelectView.frame;
            [UIView animateWithDuration:0.25 animations:^{
                unSelectView.x = oldFrame.origin.x - kTCERY(95);
            }];
        }
    }
    [self.tceSelectViews removeObject:selectBtn];
}

- (void)tceMoreNext
{
    TCEPuzzleViewController *vc = [TCEPuzzleViewController new];
    vc.tceImages = self.tceChoosePhotos;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tceSingleNext:(UIImage *)img
{
    TceEditEditViewController *vc = [TceEditEditViewController new];
    vc.needEditImg = img;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tceAllPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TCEPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TCEPhotoCollectionViewCell" forIndexPath:indexPath];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize newSize = CGSizeMake(cell.frame.size.width * scale, cell.frame.size.height * scale);
    PHAsset *asset = self.tceAllPhotos[indexPath.item];
    [_tcePHCachManager requestImageForAsset:asset targetSize:newSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.tceContentImg.image = result;
    }];
    if ([self.tceChooseCells containsObject:indexPath]) {
        cell.isSelect = YES;
    }else
    {
        cell.isSelect = NO;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TCEPhotoCollectionViewCell *cell = (TCEPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelect = !cell.isSelect;
    PHAsset *asset = self.tceAllPhotos[indexPath.item];
    [TCEPhotoManager tceGetChoosePhoto:asset viewSize:self.view.bounds.size image:^(UIImage * _Nonnull result) {
        if (self.photoType == PhotoSingleType) {
            [self tceSingleNext:result];
            return ;
        }
        if (cell.isSelect) {
            if (self.tceChoosePhotos.count > self.maxCount - 1) {
                cell.isSelect = NO;
                return ;
            }
            [cell tceButtonAnimation:cell.tceIndentyBtn];
            [self.tceChoosePhotos addObject:result];
            [self.tceChooseCells addObject:indexPath];
            [self tceSelectPhotoList:asset count:self.tceChoosePhotos.count - 1];
        }else
        {
            int i = 0;
            for (NSIndexPath *path in self.tceChooseCells) {
                if (path.row == indexPath.row) {
                    NSInteger removeRow = [self.tceChooseCells indexOfObject:path];
                    [self tceRemovePhotoWithTag:removeRow];
                    [self.tceChoosePhotos removeObjectAtIndex:i];
                }
                i++;
            }
            [self.tceChooseCells removeObject:indexPath];
        }
        
    }];
    
    NSLog(@"----%@",self.tceChoosePhotos);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TCEPhotoCollectionViewCell *cell = (TCEPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.photoType == PhotoSingleType) {
        cell.isSelect = NO;
    }
}






#pragma mark - getter
- (UICollectionView *)tcePhotoCollectionView
{
    if (!_tcePhotoCollectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake((TCE_kScreenWidth-3*2)/4, (TCE_kScreenWidth-3*2)/4)];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        layout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0);
        _tcePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _tcePhotoCollectionView.backgroundColor = [UIColor whiteColor];
        _tcePhotoCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tcePhotoCollectionView.dataSource = self;
        _tcePhotoCollectionView.delegate = self;
        [_tcePhotoCollectionView registerNib:[UINib nibWithNibName:@"TCEPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TCEPhotoCollectionViewCell"];
    }
    return _tcePhotoCollectionView;
}


- (UIView *)tceSelectPhotoView
{
    if (!_tceSelectPhotoView){
        _tceSelectPhotoView = [[UIView alloc] init];
        _tceSelectPhotoView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
        UILabel *selectLab = [[UILabel alloc] init];
        selectLab.text = @"Selected Image";
        selectLab.textColor = [UIColor whiteColor];
        selectLab.font = [UIFont systemFontOfSize:15];
        [_tceSelectPhotoView addSubview:selectLab];
        [selectLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tceSelectPhotoView).offset(5);
            make.left.equalTo(_tceSelectPhotoView).offset(10);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:tceImaged(@"ttt_rect4") forState:UIControlStateNormal];
        [btn setTitle:@"Next" forState:UIControlStateNormal];
        [btn setTitleColor:kTCERGBA(255, 182, 17, 1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tceMoreNext) forControlEvents:UIControlEventTouchUpInside];
        [_tceSelectPhotoView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(selectLab);
            make.right.equalTo(_tceSelectPhotoView).offset(-10);
        }];
        
        [_tceSelectPhotoView addSubview:self.tceSelectScrollView];
        [self.tceSelectScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_tceSelectPhotoView);
            make.bottom.equalTo(_tceSelectPhotoView).offset(-5);
            make.height.equalTo(@(kTCERY(95)));
        }];
    }
    return _tceSelectPhotoView;
}


- (NSMutableArray *)tceAllPhotos
{
    if (!_tceAllPhotos){
        _tceAllPhotos = [NSMutableArray array];
    }
    return _tceAllPhotos;
}

- (NSMutableArray *)tceChoosePhotos
{
    if (!_tceChoosePhotos){
        _tceChoosePhotos = [NSMutableArray array];
    }
    return _tceChoosePhotos;
}

- (NSMutableArray *)tceChooseCells
{
    if (!_tceChooseCells){
        _tceChooseCells = [NSMutableArray array];
    }
    return _tceChooseCells;
}

- (NSMutableArray *)tceSelectViews
{
    if (!_tceSelectViews){
        _tceSelectViews = [NSMutableArray array];
    }
    return _tceSelectViews;
}


- (UIScrollView *)tceSelectScrollView
{
    if (!_tceSelectScrollView){
        _tceSelectScrollView = [[UIScrollView alloc] init];
        _tceSelectScrollView.showsHorizontalScrollIndicator = NO;
        _tceSelectScrollView.showsVerticalScrollIndicator = NO;
    }
    return _tceSelectScrollView;
}



@end
