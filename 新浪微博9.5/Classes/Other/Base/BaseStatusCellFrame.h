//
//  BaseStatusCellFrame.h
//  新浪微博9.5
//
//  Created by homeboy on 14-10-10.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;
@interface BaseStatusCellFrame : NSObject
{
    CGFloat _cellHeight;
    CGRect _retweetedFrame;
}
@property (nonatomic,strong)Status *status;

@property (nonatomic,readonly)CGFloat cellHeight;              //cell的高度

@property (nonatomic,assign,readonly)CGRect iconFrame;         //头像的frame
@property (nonatomic,assign,readonly)CGRect screenFrame;       //昵称的frame
@property (nonatomic,assign,readonly)CGRect mbIconFrame;       //会员皇冠的frame
@property (nonatomic,assign,readonly)CGRect timeFrame;         //时间的frame
@property (nonatomic,assign,readonly)CGRect sourceFrame;       //来源的frame
@property (nonatomic,assign,readonly)CGRect textFrame;         //内容的frame
@property (nonatomic,assign,readonly)CGRect imageFrame;        //配图的frame

#warning 被转发微博的父视图
@property (nonatomic,assign,readonly)CGRect retweetedFrame;          //被转发微博的父视图
@property (nonatomic,assign,readonly)CGRect retweetedScreenNameFrame;//被转发微博作者昵称
@property (nonatomic,assign,readonly)CGRect retweetedTextFrame;      //被转发微博的内容
@property (nonatomic,assign,readonly)CGRect retweetedImageFrame;     //被转发微博的配图
@end
