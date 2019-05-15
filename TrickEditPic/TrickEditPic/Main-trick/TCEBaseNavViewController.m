//
//  TCEBaseNavViewController.m
//  TrickEditPic
//
//  Created by zzb on 2019/5/6.
//  Copyright © 2019 json. All rights reserved.
//

#import "TCEBaseNavViewController.h"

#define rgbFloat(x) (x/255.0)

@interface TCEBaseNavViewController ()

@end

@implementation TCEBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    //item
    self.navigationBar.tintColor = [UIColor whiteColor];
    //nav bar background
    self.navigationBar.barTintColor = rgba(19, 19, 19, 1);
    self.navigationBar.titleTextAttributes=@{
                                             NSForegroundColorAttributeName:[UIColor whiteColor],
                                             NSFontAttributeName : [UIFont systemFontOfSize:20 weight:5]
                                             };
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [returnBtn setImage:[UIImage imageNamed:@"fanhui-5"] forState:UIControlStateNormal];
        returnBtn.frame = CGRectMake(0, 0, 44, 44);
        returnBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [returnBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)returnAction
{
    [self popViewControllerAnimated:YES];
}

@end
