//
//  TCEStickerView.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/10.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEEditStickerView.h"
#import "TCEStickerListCell.h"
#import "UICollectionView+SideRefresh.h"
#import <UIImageView+WebCache.h>
@interface TCEEditStickerView()
<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *tceEditListView;
@property (nonatomic, strong)NSMutableArray *tceEditListDatas;
@end
@implementation TCEEditStickerView
{
    NSInteger _netIndex;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupStickerView];
        [self tceGetPageStickerDatas:_netIndex];
        [self tceFooterRefresh];
    }
    
    return self;
}

- (void)setupStickerView
{
    [self addSubview: self.tceEditListView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tceEditListDatas.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    TCEStickerListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TCEStickerListCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    [cell.tceStickerImg sd_setImageWithURL:[NSURL URLWithString:self.tceEditListDatas[indexPath.row]]];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TCEStickerListCell *cell = (TCEStickerListCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.tceStickerBlock) {
        self.tceStickerBlock(cell.tceStickerImg.image);
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
        [_tceEditListView registerNib:[UINib nibWithNibName:@"TCEStickerListCell" bundle:nil] forCellWithReuseIdentifier:@"TCEStickerListCell"];
    }
    return _tceEditListView;
}


- (NSMutableArray *)tceEditListDatas
{
    if (!_tceEditListDatas){
        _tceEditListDatas = [NSMutableArray array];
    }
    return _tceEditListDatas;
}

#pragma mark - net

- (void)tceFooterRefresh
{
    SideRefreshFooter *refreshFooter = [SideRefreshFooter refreshWithLoadAction:^{
        [self tceGetMoreStickerDatas];
    }];
    self.tceEditListView.sideRefreshFooter = refreshFooter;
}

- (void)tceGetMoreStickerDatas
{
    _netIndex++;
    [self tceGetPageStickerDatas:_netIndex];
}

- (void)tceGetPageStickerDatas : (NSInteger )index
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *str = @"http://www.wtralagge.club/newpro/canvas/TrickEditPic";
    NSDictionary *dic = @{
                          @"reliability" : @"com.newpro.TrickEditPic",
                          @"ogle" : @(_netIndex)
                          };
    
    [SVProgressHUD show];
    [[TCENetManager manager].netManager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [SVProgressHUD dismiss];
        id response = [TCENetManager tceGetDataWithDES:jsonStr];
        if ([response[@"wan"] integerValue] == 200)
        {
            for (NSDictionary *dic in response[@"sentimental"])
            {
                [arr addObject:dic[@"debility"]];
            }
            [self.tceEditListDatas addObjectsFromArray:arr];
            [self.tceEditListView.sideRefreshFooter endLoading];
            [self.tceEditListView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
    }];
}
@end
