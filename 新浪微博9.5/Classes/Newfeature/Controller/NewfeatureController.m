//
//  NewfeatureController.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-5.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  版本

#import "NewfeatureController.h"
#import "UIImage+HomeboyAdd.h" 
#import "OauthController.h"
#define kCount 4
@interface NewfeatureController ()<UIScrollViewDelegate>
{
    UIPageControl *_page;
    
}

@end

@implementation NewfeatureController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - 自定义view
- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage fullscreenImage:@"new_feature_background"];
    imageView.frame = [UIScreen mainScreen].applicationFrame;
    imageView.userInteractionEnabled = YES;
    self.view = imageView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.添加scrollView
    UIScrollView *scroll = [[UIScrollView alloc]init];
    scroll.frame = self.view.bounds;
    CGSize size = scroll.frame.size;
    scroll.contentSize = CGSizeMake(size.width * kCount, 0);
    scroll.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
        for (int i = 0; i < kCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage fullscreenImage:name];
                //2.设置fram
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [scroll addSubview:imageView];
            if (i == kCount - 1) {
                //立即体验
                UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *startImage = [UIImage imageNamed:@"new_feature_finish_button"];
                [start setBackgroundImage:startImage forState:UIControlStateNormal];
                [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
                start.center = CGPointMake(size.width *0.5, size.height * 0.8);
                start.bounds = (CGRect){CGPointZero,startImage.size};
                [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:start];
                //分享按钮     相对布局
                UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *shareImage = [UIImage imageNamed:@"new_feature_share_false"];
                // selected = NO;
                [share setBackgroundImage:shareImage forState:UIControlStateNormal];
                [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
                share.center = CGPointMake(start.center.x, start.center.y - 50);
                share.bounds = (CGRect){CGPointZero,shareImage.size};
                [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                //让分享初始为选中状态
                share.selected = YES;
                share.adjustsImageWhenHighlighted = NO;
                [imageView addSubview:share];
                imageView.userInteractionEnabled = YES;

            }
            }
    //3.添加UIPageController
    UIPageControl *page = [[UIPageControl alloc]init];
    page.center = CGPointMake(size.width *0.5, size.height *0.95);
    page.bounds = CGRectMake(0, 0, 150, 0);
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
    page.numberOfPages = kCount;
    [self.view addSubview:page];
    _page = page;
	}

#pragma mark - 滚动代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page.currentPage =  scrollView.contentOffset.x / scrollView.frame.size.width;
}
#pragma mark - start action
- (void)start
{
    NSLog(@"分享微博");
    [UIApplication sharedApplication].statusBarHidden = NO;
    //是否授权了新浪微博的登录
   self.view.window.rootViewController = [[ OauthController alloc]init];
}
- (void)share:(UIButton *)btn
{
    btn.selected  = !btn.selected;
}
- (void)dealloc
{
//    NSLog(@"new---销毁") ;
}
@end
