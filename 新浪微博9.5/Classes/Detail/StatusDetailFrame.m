//
//  StatusDetailFrame.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-10.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "StatusDetailFrame.h"
#import "Status.h"
@implementation StatusDetailFrame
- (void)setStatus:(Status *)status
{
    [super setStatus:status];
    if ( status.retweetedStatus) {
        _retweetedFrame.size.height += 35;
        _cellHeight += 35;
    }
    
}
@end
