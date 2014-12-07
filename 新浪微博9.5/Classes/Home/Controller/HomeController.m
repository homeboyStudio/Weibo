 //
//  HomeController.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-8.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#define kAppKey @"431315585"
#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define kAppSecret @"53919843fa900956260731bf1e99d6db"
#define kOauthrize @"https://api.weibo.com/oauth2/authorize"
#define kBaseURL  @"https://api.weibo.com"

#import "HomeController.h"
#import "UIBarButtonItem+WB.h"
#import "AccountTool.h"
#import "User.h"
#import "Status.h"
#import "StatusTool.h"
#import "UIImageView+WebCache.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "MJRefresh.h"
#import "UIImage+HomeboyAdd.h"
#import "StatusDetailController.h"
@interface HomeController ()<MJRefreshBaseViewDelegate>
{
    NSMutableArray *_statusFrames;
}
@end

@implementation HomeController
kHideScroll
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";

   
   //1.设置界面属性
    [self buildUI];
    //2获得用户的微博数据
    //此方法作废，进入程序会自动刷新tableView如下 [header beginRefreshing];
//    [self loadStatusData];
    //3.集成刷新控件
    [self addRefreshViews];
//    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
//    [self.tableView addSubview:refresh];
//    [refresh addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventValueChanged];
}
#pragma 集成刷新控件
- (void)addRefreshViews
{
    _statusFrames = [NSMutableArray arrayWithCapacity:10];
    //1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    //自动进入刷新状态
    [header beginRefreshing];
    //2.上拉加载更多  KVO
    MJRefreshFooterView *footed = [MJRefreshFooterView footer];
    footed.scrollView = self.tableView;
    footed.delegate = self;
    }
#pragma mark 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{

    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        //上拉加载更多
        //1.最后一条微博的Id
        StatusCellFrame *frame = [_statusFrames lastObject];
        long long last = [frame.status ID];
        //2.获取微博数据
        [StatusTool statusesWithSinceID:0 maxID:last - 1 Success:^(NSArray *statuses) {
            //1.在拿到最新微博数据的同时计算它的frame
            NSMutableArray *newFrames = [NSMutableArray array];
            for (Status *s in statuses) {

                StatusCellFrame *frame = [[StatusCellFrame alloc]init];
                frame.status = s;
                [newFrames addObject:frame];
            }
            //2.将最新的数据插入到旧数据的后面
            [_statusFrames addObjectsFromArray:newFrames];
            [self.tableView reloadData];
            [refreshView  endRefreshing];
        } failure:^(NSError *error) {
            NSLog(@"加载数据失败");
            [refreshView  endRefreshing];
        }];

    }else{
        //1.第一条微博的Id    防止数组越界  第一次加载数组里是没有数据的
        StatusCellFrame *frame = _statusFrames.count ? _statusFrames[0] : nil;
        long long first = [frame.status ID];
        //2.获取微博数据
        [StatusTool statusesWithSinceID:first maxID:0 Success:^(NSArray *statuses) {
            //1.在拿到最新微博数据的同时计算它的frame
            NSMutableArray *newFrames = [NSMutableArray array];
            for (Status *s in statuses) {
                StatusCellFrame *frame = [[StatusCellFrame alloc]init];
                frame.status = s;
                [newFrames addObject:frame];
             }
            //2.将最新的数据插入到旧数据的前面
            [_statusFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
            //3.刷新表格，重新调用数据源，代理的方法
            [self.tableView reloadData];
            //4.停止
            [refreshView  endRefreshing];
            //5.展示最新微博的数目
            [self showNewStatusCount:statuses.count];
        } failure:^(NSError *error) {
            NSLog(@"加载数据失败");
            [refreshView  endRefreshing];
        }];
    }
}
#pragma mark  展示最新的微博数目动画
- (void)showNewStatusCount:(NSUInteger)count
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.enabled = NO;
    //enable设置位no时，会自动调节原图片所以设置一下
    button.adjustsImageWhenDisabled = NO;
    [button setBackgroundImage:[UIImage resizedImage:@"timeline_new_status_background"] forState:UIControlStateNormal];
    CGFloat width = self.view.frame.size.width;
    CGFloat hight = 35;
    button.frame = CGRectMake(0, 44-hight, width, hight);
    
    NSString *title = count ?[NSString stringWithFormat:@"共有%lu条最新微博",(unsigned long)count] :@"没有新微博了";
    [button setTitle:title forState:UIControlStateNormal];
    //button 应该插入到UInavigation的下面，tableView的上面
    [self.navigationController.view insertSubview:button belowSubview:self.navigationController.navigationBar];
    //开始执行动画
    [UIView animateWithDuration:0.5 animations:^{   //下来
        button.transform = CGAffineTransformMakeTranslation(0, hight);
//        CGRect frame = button.frame;
//        frame.origin.y = 44;
//        button.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0.8 options:UIViewAnimationOptionCurveLinear animations:^{  //回去
            button.transform = CGAffineTransformIdentity;
//            CGRect frame = button.frame;
//            frame.origin.y = 44-hight;
//            button.frame = frame;
        }
        completion:^(BOOL finished) {
            [button removeFromSuperview];
        }];
   }];
}
/*- (void)startRefresh:(UIRefreshControl *)refresh
{
    //1.第一条微博的Id
    long long first = [[_statusFrames[0] status]  ID];
    NSLog(@"start");
    //2.获取微博数据
    [StatusTool statusesWithSinceID:first maxID:0 Success:^(NSArray *statuses) {
        //1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *frame = [[StatusCellFrame alloc]init];
            frame.status = s;
            [newFrames addObject:frame];
        }
         //2.将最新的数据插入到旧数据的前面
        [_statusFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        //3.刷新表格，重新调用数据源，代理的方法
        [self.tableView reloadData];
        //4.停止
        [refresh endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"加载数据失败");
    }];
}*/
#pragma mark - 设置见面属性
- (void)buildUI
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithIcon:@"navigationbar_compose" highlightedIcon:@"navigationbar_compose_highlighted" tagert:self action:@selector(sendStatus)];
    //2.右边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithIcon:@"navigationbar_pop" highlightedIcon:@"navigationbar_pop_highlighted" tagert:self action:nil];
    
    self.view.backgroundColor = KColor(230, 230, 230);
    //去除tableView中的cell的分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)sendStatus
{
    NSLog(@"发送微博");
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        cell.textLabel.numberOfLines = 0;   //自动换行
//        cell.textLabel.font = [UIFont systemFontOfSize:15];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
//     Status *s = _statuses[indexPath.row];
       //在主线程中进行下载图片，会造成堵塞
//    NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:s.user.profileImageUrl]];
//    cell.imageView.image = [UIImage imageWithData:data];
    //异步下载图片
//    [cell.imageView setImageWithURL:[NSURL URLWithString:s.user.profileImageUrl]placeholderImage:[UIImage imageNamed:@"icon"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    cell.CellFrame = _statusFrames[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_statusFrames[indexPath.row] cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusDetailController *detail = [[StatusDetailController alloc]init];
    StatusCellFrame *f = _statusFrames[indexPath.row];
    detail.status = f.status;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
