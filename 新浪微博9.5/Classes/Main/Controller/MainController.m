//
//  MainController.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-6.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "MainController.h"
#import "Dock.h"
#import "HomeController.h"
#import "MeController.h"
#import "MessageController.h"
#import "SquareController.h"
#import "MoreController.h"  
#import "WBNavigationController.h"
#import "DockController.h"
#import "UIBarButtonItem+WB.h"
#define kDockHeight 44
@interface MainController ()<UINavigationControllerDelegate>
@end

@implementation MainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化所以子控制器
    [self addAllChildControllers];
    
    //初始化Dock
    [self addDockItems];
    }
#pragma marrk  -添加Dock与所有子控制器
- (void)addAllChildControllers
{
    //3.初始化所有的子控制器
    //成员变量，在viewdidload后会销毁
    HomeController *home = [[HomeController alloc]init];
    home.view.backgroundColor = [UIColor whiteColor];
    home.view.frame = CGRectMake(0, 0, home.view.frame.size.width, home.view.frame.size.height);
    UINavigationController *nav = [[WBNavigationController alloc]initWithRootViewController:home];
    nav.delegate = self;
    //消息
    MessageController *msg = [[MessageController alloc]init];
    WBNavigationController *nav2 = [[WBNavigationController alloc]initWithRootViewController:msg];
      nav2.delegate = self;
    //我
    MeController *me = [[MeController alloc]init];
    WBNavigationController *nav3 = [[WBNavigationController alloc]initWithRootViewController:me];
    nav3.delegate = self;
    //广场
   SquareController *square = [[SquareController alloc]init];
    WBNavigationController *nav4 = [[WBNavigationController alloc]initWithRootViewController:square];
    nav4.delegate = self;
    //更多
    MoreController *more = [[MoreController alloc]initWithStyle:UITableViewStyleGrouped];
       UINavigationController *nav5 = [[WBNavigationController alloc]initWithRootViewController:more];
    nav5.delegate = self;
    
    [self addChildViewController:nav];
    [self addChildViewController:nav2];
    [self addChildViewController:nav3];
    [self addChildViewController:nav4];
    [self addChildViewController:nav5];

}
- (void)addDockItems
{
    //2.往dock里面填充内容
    [_dock addItemWithIcon:@"tabbar_home" selectedIcon:@"tabbar_home_selected" title:@"首页"];
    [_dock addItemWithIcon:@"tabbar_message_center" selectedIcon:@"tabbar_message_center_selected" title:@"消息"];
    [_dock addItemWithIcon:@"tabbar_profile" selectedIcon:@"tabbar_profile_selected" title:@"我"];
    [_dock addItemWithIcon:@"tabbar_discover" selectedIcon:@"tabbar_discover_selected" title:@"广场"];
    [_dock addItemWithIcon:@"tabbar_more" selectedIcon:@"tabbar_more_selected" title:@"更多"];
}
#pragma mark - navigation delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果显示的不是根控制器就需要拉长导航控制的view的高度
    //获得当前导航控制的的根控制器
   UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController) {   //不是根控制器
        //2.拉长导航控制器的view
        CGRect frame = navigationController.view.frame;//{{0, 0}, {320, 416}}
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.height;    //460
        navigationController.view.frame = frame;                                   //{{0, 0}, {320, 460}}
        //3.添加Dock到根控制器的view上
        [_dock removeFromSuperview];
        //调整dock的y值
        CGRect dockFrame = _dock.frame;
        //{{0, 416}, {320, 44}}     nav 416 --->460     roor 372  ---> 416     dook   ----->  416 - 44
        dockFrame.origin.y = root.view.frame.size.height - _dock.frame.size.height;    //416 - 44 = 372
        if ([root.view isKindOfClass:[UIScrollView class]]) {   //根控制的view是能滚动的
            UIScrollView *scroll = (UIScrollView *)root.view;
            dockFrame.origin.y += scroll.contentOffset.y;
        }
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        //4.添加左上角的的返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithIcon:@"navigationbar_back" highlightedIcon:@"navigationbar_back_highlighted" tagert:self action:@selector(back:)];
    }
}
- (void)back:(UINavigationController *)detail
{
    [self.childViewControllers[_dock.selectedIndex] popViewControllerAnimated:YES];
}
//  dock.frame =  {{0, 416}, {320, 44}};
//  navigationController.view.frame = {{0, 0},{320, 416}}     --->    //{{0, 0}, {320, 460}}   实际上显示的view为416
//  调整dock的y值    {{0,372},{320,44}}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        //1.让导航控制器view的高度还原
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.height - _dock.frame.size.height;
        navigationController.view.frame = frame;
        //2.添加Dock到mainView上面
        [_dock removeFromSuperview];
        //调整dock的y值
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
     }
}
@end