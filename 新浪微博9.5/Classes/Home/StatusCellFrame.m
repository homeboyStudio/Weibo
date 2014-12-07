//
//  StatusCellFrame.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "StatusCellFrame.h"
#import "IconView.h"
#import "ImageListView.h"
#import "Status.h"
#define kMBIconWidth 14      //皇冠大小
#define kMBIconHight 14

#define kCellBorderWidth 10  //边框间距

@implementation StatusCellFrame
- (void)setStatus:(Status *)status
{
    [super setStatus:status];
    _cellHeight += kStatusDockHeight;
}
    @end
