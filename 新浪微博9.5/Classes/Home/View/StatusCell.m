//
//  StatusCell.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-24.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "StatusDock.h"

@interface StatusCell()
{
       StatusDock *_dock;       //操作条
    
}
@end
@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //7.操作条
        CGFloat y = self.frame.size.height - kStatusDockHeight;
        _dock = [[StatusDock alloc]initWithFrame:CGRectMake(0, y, 0, 0)];
        [self.contentView addSubview:_dock];
    }
    return self;
}
 
- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    _dock.status =  cellFrame.status;
}
@end
