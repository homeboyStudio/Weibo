//
//  ImageItemView.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-4.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "ImageItemView.h"
#import "HttpTool.h"
@interface ImageItemView()
{
    UIImageView *_gifView;
}
@end
@implementation ImageItemView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:_gifView];
        
        
    }
    return self;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    //1.加载图片
//    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"timeline_image_loading"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    [HttpTool downloadImage:url place:[UIImage imageNamed:@"timeline_image_loading"] imageView:self];
    //2.判断是否位gif
    if([url.lowercaseString hasSuffix:@"gif"]){
        _gifView.hidden = NO;
        
    }else{
        _gifView.hidden = YES;
    }
}
- (void)setFrame:(CGRect)frame
{
    //设置gifView的位置
    CGRect gifFrame = _gifView.frame;
    gifFrame.origin.x = frame.size.width - gifFrame.size.width;
    gifFrame.origin.y = frame.size.height - gifFrame.size.height;
    _gifView.frame = gifFrame;
    [super setFrame:frame];
}
@end
