//
//  BaseStatusCellFrame.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-10.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "ImageListView.h"
@implementation BaseStatusCellFrame
- (void)setStatus:(Status *)status
{
    _status = status;
    //利用微博数据，计算所有子控件frame
    
    //整个cell的宽度
    CGFloat cellWidth =  [UIScreen mainScreen].bounds.size.width - 2*kTableBorderWidth;
    //1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    CGSize iconSize = [IconView iconWithTyper:kIconTypeSmall];
    _iconFrame = CGRectMake(iconX,iconY, iconSize.width,iconSize.height);
    
    //2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat screenNameY = kCellBorderWidth + 1;
    CGSize screenNameHeight =  [status.user.screenName sizeWithFont:kScreenNameFont];
    _screenFrame = CGRectMake(screenNameX,screenNameY,screenNameHeight.width, screenNameHeight.height);
    if (status.user.mbtype != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenFrame) + kCellBorderWidth;
        CGFloat mbIconY = screenNameY + (screenNameHeight.height - kMBIconHight)*0.5;
        _mbIconFrame = (CGRect){{mbIconX,mbIconY},kMBIconWidth,kMBIconHight};
        
    }
    //时间
    CGFloat timeX = screenNameX;
    CGFloat timeY = CGRectGetMaxY(_screenFrame) + kCellBorderWidth;
    CGSize timeSize = [status.createdAt sizeWithFont:kTimeFont];
    _timeFrame =  (CGRect){{timeX,timeY},timeSize};
    
    //4.来源
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) + kCellBorderWidth;
    CGFloat sourceY =  timeY;
    CGSize sourceSize = [status.source sizeWithFont:kSourceFont];
    _sourceFrame = (CGRect){{sourceX, sourceY},sourceSize};
    
    //5.微博内容
    CGFloat textX = iconX;
    CGFloat maxY = MAX(CGRectGetMaxY(_sourceFrame), CGRectGetMaxY(_iconFrame));
    CGFloat textY = maxY + kCellBorderWidth;
    CGSize textSize = [status.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(cellWidth - 2*kCellBorderWidth , MAXFLOAT)];
    _textFrame = (CGRect){{textX,textY},textSize};
    
    
    if(status.picUrls.count){             //6.有配图
        CGFloat imageX = textX;
        CGFloat imageY =CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGSize imageSize = [ImageListView imageListSizeWithCount:status.picUrls.count];
        _imageFrame = (CGRect){{imageX,imageY},{imageSize.width,imageSize.height}};
    }else if(status.retweetedStatus){     //7有转发的微博
        //被转发微博整体
        CGFloat retweetedX =  textX;
        CGFloat retweetedY =  CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGFloat retweetedWidth = cellWidth - 2*kCellBorderWidth;
        CGFloat retweetedHeight = kCellBorderWidth;
        //8.被转发微博的昵称
        CGFloat retweetedSrceenNameX = kCellBorderWidth;
        CGFloat retweetedScreenNameY =  kCellBorderWidth;
        NSString *screenName = [NSString stringWithFormat:@"@%@",status.retweetedStatus.user.screenName];
        CGSize retweetedScreenNameSize = [screenName  sizeWithFont:kRetweetedScreenNameFont];
        _retweetedScreenNameFrame = (CGRect){{retweetedSrceenNameX,retweetedScreenNameY},retweetedScreenNameSize};
        
        //9.被转发微博的内容
        CGFloat retweetedTextX = retweetedSrceenNameX;
        CGFloat retweetedTextY =  CGRectGetMaxY(_retweetedScreenNameFrame) + kCellBorderWidth;
        //这里要注意这里是被转发微博的父视图
        CGFloat retweetedTextWidth = retweetedWidth - 2*kCellBorderWidth;
        CGSize retweetedTextSize = [status.retweetedStatus.text sizeWithFont:kRetweetedTextFont constrainedToSize:CGSizeMake(retweetedTextWidth , MAXFLOAT)];
        _retweetedTextFrame = (CGRect){{retweetedTextX,retweetedTextY},retweetedTextSize};
        //10.被转发微博的配图
        if (status.retweetedStatus.picUrls.count) {
            CGFloat retweetedImageX = retweetedTextX;
            CGFloat retweetedImageY = CGRectGetMaxY(_retweetedTextFrame) + kCellBorderWidth;
            int count = status.retweetedStatus.picUrls.count;
            CGSize  imageSize = [ImageListView imageListSizeWithCount:count];
            _retweetedImageFrame = (CGRect){{retweetedImageX,retweetedImageY},{imageSize.width,imageSize.height}};
            retweetedHeight += CGRectGetMaxY(_retweetedImageFrame);
        }else{
            retweetedHeight += CGRectGetMaxY(_retweetedTextFrame);
        }
        //11.被转发微博整体的Frame
        _retweetedFrame = CGRectMake(retweetedX, retweetedY, retweetedWidth, retweetedHeight);
    }
    //12.整个cell的高度
    _cellHeight = kCellBorderWidth + kCellMargin;
    if (status.picUrls.count) {
        _cellHeight += CGRectGetMaxY(_imageFrame);
    }else if(status.retweetedStatus){
        _cellHeight  += CGRectGetMaxY(_retweetedFrame);
    }else{
        _cellHeight += CGRectGetMaxY(_textFrame);
    }
}

@end
