//
//  RetweetedDock.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-11.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "RetweetedDock.h"
#import "UIImage+HomeboyAdd.h"
#import "NSString+png.h"
#import "Status.h"
@interface RetweetedDock()
{
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitute;
}

@end
@implementation RetweetedDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.添加三个按钮
        _repost = [self addBtn:@"转发" icon:@"timeline_icon_retweet" bg:@"timeline_card_leftbottom" index:0];
        _comment =  [self addBtn:@"评论" icon:@"timeline_icon_comment" bg:@"timeline_card_middlebottom" index:1];
        _attitute = [self addBtn:@"赞" icon:@"timeline_icon_unlike" bg:@"timeline_card_rightbottom" index:2];
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.size.width = 200;
    frame.size.height = 35;
    [super setFrame:frame];
}
- (UIButton *)addBtn:(NSString *)title icon:(NSString *)icon bg:(NSString *)bg index:(int)index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //标题
    [btn setTitle:title forState:UIControlStateNormal];
    //图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //背景
    [btn setBackgroundImage:[UIImage resizedImage:@"common_button_big_red"]forState:UIControlStateHighlighted];
    
    [btn setTitleColor:KColor(188, 188, 188) forState:UIControlStateNormal];
    //字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    //微调button内部控件
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //设置fram
    CGFloat w = self.frame.size.width/3;
    btn.frame = CGRectMake(w * index, 0, w, kStatusDockHeight);
    [self addSubview:btn];
       return btn;
}
 -(void)setStatus:(Status *)status
{
    _status = status;
    //1.转发按钮
    [self setBtn:_repost Title:@"0" count:status.repostsCount];
    //2.评论
    [self setBtn:_comment Title:@"0" count:status.commentsCount];
    //3.赞
    [self setBtn:_attitute Title:@"0" count:status.attitudesCount];
}
- (void)setBtn:(UIButton *)button Title:(NSString *)title count:(int)count
{
    if (count >= 10000) {  //上万
        CGFloat numbers = count / 10000.0 ;
        NSString *repost = [NSString stringWithFormat:@"%.1f万",numbers];
        //替换.0为 空
        repost = [repost stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [button setTitle:repost forState:UIControlStateNormal];
    }else if(count > 0){   //一万以内
        NSString *repost = [NSString stringWithFormat:@"%d",count];
        [button setTitle:repost forState:UIControlStateNormal];
    }else{           //没有
        [button setTitle:title forState:UIControlStateNormal];
    }
}
@end
