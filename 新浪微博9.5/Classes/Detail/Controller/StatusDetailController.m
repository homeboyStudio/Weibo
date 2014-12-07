//
//  StatusDetailController.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-7.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "StatusDetailController.h"
#import "statusDetailCell.h"
#import "StatusDetailFrame.h"
#import "DetailHeader.h"
@interface StatusDetailController ()
{
    StatusDetailFrame *_detailFrame;
}
@end

@implementation StatusDetailController
kHideScroll
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
    self.title = @"微博正文";
    self.view.backgroundColor = KColor(188, 188, 188);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //算好frame
    _detailFrame = [[StatusDetailFrame alloc]init];
    _detailFrame.status = _status;
    }
#pragma mark 数据源\代理方法
#pragma mark 1.有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma mark 2.第section组头部有多高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    return 45;
}
#pragma mark 3.第section有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return 50;
    
}
#pragma mark 4.第indexPath的cell有多高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    }
    return 44;
}
#pragma mark 5.indexPath这行的cell什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {  //微博详情cell
        static NSString *CellIdentifier = @"DetailCell";
        statusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
            cell = [[statusDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.cellFrame = _detailFrame;
        return cell;
}
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}
#pragma mark 6.第section组头部显示什么控件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    DetailHeader *detail = [DetailHeader header];
    detail.status = _status;
    return  detail;
}
#pragma mark - 判断第indexpath行的cell能否选中高亮状态
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section;
}
@end
