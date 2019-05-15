//
//  TCEDoorViewController.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEDoorViewController.h"

@interface TCEDoorViewController ()

@end

@implementation TCEDoorViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //    return UIStatusBarStyleLightContent; //返回白色
    return UIStatusBarStyleDefault;    //返回黑色
}

- (BOOL)prefersStatusBarHidden {
    return YES;  //设置状态栏隐藏
    //    return NO; //设置状态栏显示
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self TCEFinished];
}

- (void)TCEFinished
{
    if (self.doorBlock) {
        self.doorBlock();
    }
}

@end
