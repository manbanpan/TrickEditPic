//
//  TceEditBorderView.m
//  Picture Editing
//
//  Created by zzb on 2019/4/12.
//  Copyright © 2019 李十亿. All rights reserved.
//

#import "TceEditBorderView.h"
#import "TceEditBorderListCell.h"
//#import "NSString+Json.h"
@interface TceEditBorderView()
<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *tceEditListView;
@property (nonatomic, strong)NSMutableArray *tceEditListDatas;
@end

@implementation TceEditBorderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self tceEdit_get_border];
        [self setupBorderView];
    }
    
    return self;
}

- (void)setupBorderView
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
    TceEditBorderListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TceEditBorderListCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    cell.tceEdit_image.image = self.tceEditListDatas[indexPath.row];
    
    return cell;
}
//TceEditDingYtViewController *sub = [TceEditDingYtViewController new];
//[self presentViewController:sub animated:YES completion:nil];
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15/2, 10, 15/2, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.borderBlock) {
        self.borderBlock(self.tceEditListDatas[indexPath.row]);
    }
}

- (UIViewController * )TceEdit_presentCC:(UIView *)views{
    UIResponder * next = [views nextResponder];
    while (next!=nil) {
        if([next isKindOfClass:[UIViewController class]]){
            return (UIViewController * )next;
        }
        next = [next nextResponder];
    }
    return nil;
}


#pragma mark - get
- (UICollectionView *)tceEditListView
{
    if (!_tceEditListView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(50, 50);
        _tceEditListView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _tceEditListView.showsHorizontalScrollIndicator = NO;
        _tceEditListView.backgroundColor = [UIColor clearColor];
        _tceEditListView.dataSource = self;
        _tceEditListView.delegate = self;
        [_tceEditListView registerNib:[UINib nibWithNibName:@"TceEditBorderListCell" bundle:nil] forCellWithReuseIdentifier:@"TceEditBorderListCell"];
    }
    return _tceEditListView;
}


- (NSMutableArray *)tceEditListDatas
{
    if (!_tceEditListDatas){
        _tceEditListDatas = [NSMutableArray array];
        for (int i = 1; i<=38; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            if (img) {
                [_tceEditListDatas addObject:img];
            }
        }
    }
    return _tceEditListDatas;
}


- (void)tceEdit_get_border
{
    
    NSString *usl = @"http://www.tceEdittamcea.club/billow/tceEdittamcea";;
    NSDictionary *dic = @{
                          @"hoof" : @"com.tceEdittamcea.club",
                          @"well" : @"1"
                          };
    
//    [SVProgressHUD show];
//
//    [[TceEditAFNetwork tceEditAFNetwork].manager POST:usl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        id response = [jsonStr tceEdit_analysisWithAES];
//        [SVProgressHUD dismiss];
//        if ([response[@"reproduction"] integerValue] == 200) {
//
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//    }];
}



@end
