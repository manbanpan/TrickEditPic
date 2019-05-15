//
//  TCEHomeViewController.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEHomeViewController.h"
#import "TCEPhotoViewController.h"
@interface TCEHomeViewController ()

@end

@implementation TCEHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack; //白色
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"]
//                                                            valueForKey:@"statusBar"];
//     if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//         statusBar.backgroundColor = [UIColor greenColor];
//     }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//        self.navigationController.navigationBar.barStyle = UIBarStyleDefault; //黑色
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self TCESetupHomeView];
    
}

- (void)TCESetupHomeView
{
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ttt_bg"]];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"ttt_edit"] forState:UIControlStateNormal];
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [editBtn setTitleColor:rgba(254, 99, 105, 1) forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(TCEEditPic) forControlEvents:UIControlEventTouchUpInside];
    editBtn = [UIButton TCEBtnWithType:ButtonTypeTop withButton:editBtn withSpace:5];
    
    UIButton *puzzleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [puzzleBtn setImage:[UIImage imageNamed:@"ttt_pullze"] forState:UIControlStateNormal];
    [puzzleBtn setTitle:@"Puzzle" forState:UIControlStateNormal];
    [puzzleBtn setTitleColor:rgba(254, 146, 20, 1) forState:UIControlStateNormal];
    [puzzleBtn addTarget:self action:@selector(TCEPuzzlePic) forControlEvents:UIControlEventTouchUpInside];
    puzzleBtn = [UIButton TCEBtnWithType:ButtonTypeTop withButton:puzzleBtn withSpace:5];
    
    [self.view addSubview:editBtn];
    [self.view addSubview:puzzleBtn];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-tceBarH - tceRY(40));
        make.left.equalTo(self.view).offset(tceRX(71));
        make.width.equalTo(@(tceRX(80)));
    }];
    
    [puzzleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(editBtn);
        make.right.equalTo(self.view).offset(-tceRX(71));
        make.width.equalTo(@(tceRX(80)));
    }];
    
}

#pragma mark - Action
- (void)TCEEditPic
{
    TCEPhotoViewController *vc = [TCEPhotoViewController new];
    vc.photoType = PhotoSingleType;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)TCEPuzzlePic
{
    TCEPhotoViewController *vc = [TCEPhotoViewController new];
    vc.photoType = PhotoMoreType;
    vc.tceTitle = @"All Photos";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
