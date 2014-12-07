//
//  MoreController.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-8.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "MoreController.h"
#import "UIImage+HomeboyAdd.h"
#import "GroupCell.h"
@interface logutBtn : UIButton

@end
@implementation logutBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 20;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2*x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
@end

@implementation MoreController
{
    NSArray *_data;
}
kHideScroll
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      self.title = @"更多";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:nil action:nil];
    //加载plist
    [self loadPlist];
    
    [self buildTableView];
    }
#pragma mark - 设置tableView属性
- (void)buildTableView
{
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = KColor(230,230,230);


      //设置tableView每组头部的高度
    self.tableView.sectionFooterHeight = 5;
    self.tableView.sectionHeaderHeight = 5;
    
    //要在tableView底部添加一个按钮
    logutBtn *button = [[logutBtn alloc]init];
    [button setBackgroundImage:[UIImage resizedImage:@"common_button_big_red"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImage:@"common_button_big_red_highlighted"] forState:UIControlStateHighlighted];
    //默认是整个tableView的宽度
    button.bounds = CGRectMake(0, 0, 0, 44);
    [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
    self.tableView.tableFooterView = button;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == _data.count - 1) {
        return 10;
    }
}
- (void)loadPlist
{
    //获取路径
   NSURL *url = [[NSBundle mainBundle]URLForResource:@"More" withExtension:@"plist"];
    //读取数据
   _data = [NSArray arrayWithContentsOfURL:url];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //这个方法是要结合storeboard来配套使用的
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.myTableView = tableView;
          }
        //取出这行对应字典的数据
    NSDictionary *dic = _data[indexPath.section][indexPath.row];
    cell.textLabel.text = dic[@"name"];
    
    cell.indexPath = indexPath;
    
    //设置cell类型
    if (indexPath.section == 2) {
        cell.cellType = kCellTypeLabel;
        cell.rightLabel.text = indexPath.row?@"有图模式":@"经典模式";
    }else{
        cell.cellType = kCellTypeArrow;
    }
       return cell;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




@end
