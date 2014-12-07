//
//  statusDetailCell.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-10.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  微博详情中的cell

#import "statusDetailCell.h"
#import "RetweetedDock.h"
#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "StatusDetailController.h"
#import "MainController.h"
@interface statusDetailCell()
{
    RetweetedDock *_dock;
}
@end
@implementation statusDetailCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.操作条
        RetweetedDock *dock = [[RetweetedDock alloc]init];
        dock.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        dock.frame = CGRectMake(_retweeted.frame.size.width - dock.frame.size.width, _retweeted.frame.size.height - dock.frame.size.height, 0, 0);
        [_retweeted addSubview:dock];
        _dock = dock;
        //2.监听被转发微博的点击
        [_retweeted addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRetweeted)]];
    }
    return self;
}
- (void)showRetweeted
{
    StatusDetailController *detail = [[StatusDetailController alloc]init];
    detail.status = _dock.status;
   MainController *main = (MainController *)self.window.rootViewController;
    UINavigationController *nav = (UINavigationController *)main.selectedController;
    [nav pushViewController:detail animated:YES];
    
}
- (void) setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    //设置子控件的数据
    _dock.status = cellFrame.status.retweetedStatus;
}

@end
