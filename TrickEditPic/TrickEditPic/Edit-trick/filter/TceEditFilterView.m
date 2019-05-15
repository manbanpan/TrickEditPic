//
//  TceEditFilterView.m
//  Picture Editing
//
//  Created by zzb on 2019/4/10.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditFilterView.h"
#import "TceEditFilterListCell.h"
#import "TceEditAllFilterManager.h"
@interface TceEditFilterView()
<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *tceEditListView;
@property (nonatomic, strong)NSMutableArray *tceEditListDatas;

@end

@implementation TceEditFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupFilterView];
    }
    
    return self;
}

- (void)setupFilterView
{
    [self addSubview: self.tceEditListView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [TceEditAllFilterManager tceEditAllNewImgWithFilter].count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *imgs = [TceEditAllFilterManager tceEditAllNewImgWithFilter];
    NSArray *names = [TceEditAllFilterManager tceEdit_Name];
    TceEditFilterListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TceEditFilterListCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    cell.tceEdit_ImgView.image = imgs[indexPath.row];
    cell.tceEdit_lab.text = names[indexPath.row];

    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.filterBlock) {
        self.filterBlock(indexPath.row);
    }
}


#pragma mark - get
- (UICollectionView *)tceEditListView
{
    if (!_tceEditListView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(65, 65);
        _tceEditListView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _tceEditListView.showsHorizontalScrollIndicator = NO;
        _tceEditListView.backgroundColor = [UIColor clearColor];
        _tceEditListView.dataSource = self;
        _tceEditListView.delegate = self;
        [_tceEditListView registerNib:[UINib nibWithNibName:@"TceEditFilterListCell" bundle:nil] forCellWithReuseIdentifier:@"TceEditFilterListCell"];
    }
    return _tceEditListView;
}

@end
