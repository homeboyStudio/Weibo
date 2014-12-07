//
//  BaseStatusCell.h
//  新浪微博9.5
//
//  Created by homeboy on 14-10-10.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseStatusCellFrame;
@interface BaseStatusCell : UITableViewCell
{
    UIImageView *_retweeted;        //被转发微博的父视图
}
@property (nonatomic,strong)BaseStatusCellFrame *cellFrame;
@end
