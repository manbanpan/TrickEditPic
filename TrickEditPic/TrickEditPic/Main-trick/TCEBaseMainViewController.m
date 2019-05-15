//
//  TCEBaseMainViewController.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEBaseMainViewController.h"

@interface TCEBaseMainViewController ()
@property (nonatomic, strong) CAGradientLayer *startGradientLayer;
@end

@implementation TCEBaseMainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack; //白色
    //    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"]
    //                                                            valueForKey:@"statusBar"];
    //     if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
    //         statusBar.backgroundColor = [UIColor greenColor];
    //     }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self TCESetupBaseView];
    
}

- (void)TCESetupBaseView
{
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.startGradientLayer = [CAGradientLayer layer];
    self.startGradientLayer.frame = self.view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.view.layer addSublayer:self.startGradientLayer];
    
    //设置渐变区域的起始和终止位置（颜色渐变范围为0-1）
    self.startGradientLayer.startPoint = CGPointMake(0.5, 0);
    self.startGradientLayer.endPoint = CGPointMake(0.5, 1);
    
    //设置颜色数组
    self.startGradientLayer.colors = @[(__bridge id)rgba(55, 203, 168, 0.5).CGColor,
                                       (__bridge id)rgba(90, 214, 253, 0.5).CGColor,
                                       (__bridge id)rgba(253, 162, 16, 0.5).CGColor,
                                       (__bridge id)rgba(251, 82, 99, 0.5).CGColor];

    //设置颜色分割点（区域渐变范围：0-1）
    self.startGradientLayer.locations = @[@(0.25f), @(0.5f),@(0.75),@(1.0)];
    
}

@end
