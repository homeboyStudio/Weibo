//
//  DetailHeader.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-11.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "DetailHeader.h"
#import "Status.h"
@interface DetailHeader()
{
    UIButton *_selectedBtn;
}
@end

@implementation DetailHeader
#pragma mark 监听按钮点击
- (IBAction)btnClick:(UIButton *)sender {
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    [UIView animateWithDuration:0.4 animations:^{
        //移动三角形指示器
        CGPoint center = _hint.center;
        center.x = sender.center.x;
        _hint.center = center;
    }];
    
}

+(id)header
{
    return [[NSBundle mainBundle]loadNibNamed:@"DetailHeader" owner:nil options:nil][0];
}
- (void)awakeFromNib
{
    [self btnClick:self.comment];
}
//使用xib文件该不会加载该方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//    UIImage *image = [UIImage resizedImage:@"statusdetail_comment_top_background"];
//    [image drawInRect:rect];
//}
- (void)setStatus:(Status *)status
{
    _status = status;
  
    [self setBtn:_comment Title:@"评论" count: status.commentsCount];
    [self setBtn:_repost Title:@"转发" count:status.repostsCount];
    [self setBtn:_attitude Title:@"赞" count:  status.attitudesCount];
}

- (void)setBtn:(UIButton *)button Title:(NSString *)title count:(int)count
{
    if (count >= 10000) {  //上万
        CGFloat numbers = count / 10000.0 ;
        NSString *repost = [NSString stringWithFormat:@"%.1f万 %@",numbers,title];
        //替换.0为 空
        repost = [repost stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [button setTitle:repost forState:UIControlStateNormal];
    }else if(count > 0){   //一万以内
        NSString *repost = [NSString stringWithFormat:@"%d %@",count,title];
        [button setTitle:repost forState:UIControlStateNormal];
    }else{           //没有
        [button setTitle:[NSString stringWithFormat:@"0 %@",title] forState:UIControlStateNormal];
    }
}

@end
