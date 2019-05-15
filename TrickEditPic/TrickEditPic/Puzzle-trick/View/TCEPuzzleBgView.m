//
//  TCEPuzzleBgView.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/9.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEPuzzleBgView.h"
@interface TCEPuzzleBgView()
<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *tceBgCollectionView;
@property (nonatomic, strong)NSMutableArray *tceBgImgs;
@end
@implementation TCEPuzzleBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self tceSetupPuzzleBgView];
    }
    
    return self;
}


- (void)tceSetupPuzzleBgView
{
    [self addSubview: self.tceBgCollectionView];
    [self.tceBgCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@(tceRY(65)));
    }];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tceBgImgs.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TCEPuzzleBgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TCEPuzzleBgCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    cell.tceImageView.image = self.tceBgImgs[indexPath.row];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegates respondsToSelector:@selector(tcePuzzleBgView:didSelectImg:)]) {
        [self.delegates tcePuzzleBgView:self didSelectImg:self.tceBgImgs[indexPath.row]];
    }
}



#pragma mark - lazy
- (UICollectionView *)tceBgCollectionView
{
    if (!_tceBgCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(tceRY(65), tceRY(65));
        _tceBgCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _tceBgCollectionView.showsHorizontalScrollIndicator = NO;
        _tceBgCollectionView.backgroundColor = [UIColor clearColor];
        _tceBgCollectionView.dataSource = self;
        _tceBgCollectionView.delegate = self;
        [_tceBgCollectionView registerClass:[TCEPuzzleBgCell class] forCellWithReuseIdentifier:@"TCEPuzzleBgCell"];
        
    }
    return _tceBgCollectionView;
}

- (NSMutableArray *)tceBgImgs
{
    if (!_tceBgImgs){
        _tceBgImgs = [NSMutableArray array];
        for (int i = 1; i<32; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Puzzle_bg_%d",i]];
            [_tceBgImgs addObject:image];
        }
    }
    return _tceBgImgs;
}

@end

@implementation TCEPuzzleBgCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.tceImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.tceImageView];
    }
    return self;
}

@end
