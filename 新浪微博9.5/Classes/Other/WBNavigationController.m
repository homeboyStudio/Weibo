//
//  WBNavigationController.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-14.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //4.背景颜色appearance，返回一个导航栏的外观对象，相当于修改整个项目中的导航栏
    self.view.backgroundColor  = [UIColor whiteColor];
    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    //5.设置导航栏文字的主题,存放结构体先要封装成对象
    [bar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor],UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]}];
    
    //6.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal    barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted  barMetrics:UIBarMetricsDefault];
    //6.修改所有UIBarButtonItem上得文字样式颜色图片等
    NSDictionary *dic = @{UITextAttributeTextColor : [UIColor blackColor],UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]};
    [barItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    
    //设置状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
