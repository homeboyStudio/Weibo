//
//  BaseStatusCell.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-10.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  所有微博的

#import "BaseStatusCell.h"
#import "IconView.h"
#import "ImageListView.h"
#import "UIImage+HomeboyAdd.h"
#import "Status.h"
#import "BaseStatusCellFrame.h"
#import "User.h"
@interface BaseStatusCell()
{
    IconView    *_icon;      //头像
    UILabel *_screenName;    //昵称
    UIImageView *_mbIcon;    //会员皇冠
    UILabel *_time;          //时间
    UILabel *_source;        //来源
    UILabel *_text;          //内容
    ImageListView *_image;   //配图
    
    UILabel *_retweetedScreenName;  //被转发微博的作者昵称
    UILabel *_retweetedText;        //被转发微博的内容
    ImageListView *_retweetedImage;   //被转发微博的配图


}
@end
@implementation BaseStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.添加微博本身的子控件
        [self addAllSubviews];
        //2.添加被转发微博的子控件
        [self addRetweetedAllSubview];
        //3.设置背景
        [self setBg];

    }
    return self;
}

- (void)setBg
{
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage resizedImage:@"common_card_background"]];
    self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage resizedImage:@"common_card_background_highlighted"]];
    
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = kTableBorderWidth;
    frame.size.width -= 2*kTableBorderWidth;
    //所有cell的origin.y都向下移动10个像素
    frame.origin.y += kTableBorderWidth;
    //把每个cell的高减小10，既每个cell向上拉10
    frame.size.height -= kCellMargin;
    //把fram传到父控件中设置自己的宽高.
    [super setFrame:frame];
}
#pragma mark - 添加微博本身的子控件
- (void)addAllSubviews
{
    //1.头像
    _icon = [[IconView alloc]init];
    [self.contentView addSubview:_icon];
    //2.昵称
    _screenName = [[UILabel alloc]init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    _mbIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_membership"]];
    [self.contentView addSubview:_mbIcon];
    
    //3.时间
    _time = [[UILabel alloc]init];
    _time.font = kTimeFont;
    _time.textColor = kColor(246,167,73);
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    //4.来源
    _source = [[UILabel alloc]init];
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    //5.内容
    _text = [[UILabel alloc]init];
    _text.numberOfLines = 0;
    _text.font = kTextFont;
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
    //6.配图
    _image =[[ImageListView alloc]init];
    [self.contentView addSubview:_image];
   
}
#pragma mark - 添加被转发微博的子控件
- (void)addRetweetedAllSubview
{
    //被转发微博的父视图
    _retweeted = [[UIImageView alloc]init];
    _retweeted.image = [UIImage resizedImage:@"timeline_retweet_background" xPos:0.9 yPos:0.5];
    _retweeted.userInteractionEnabled = YES;
    [self.contentView addSubview:_retweeted];
    //被转发微博的作者昵称
    _retweetedScreenName = [[UILabel alloc]init];
    _retweetedScreenName.font =  kRetweetedScreenNameFont;
    _retweetedScreenName.textColor = kColor(63, 104, 161);
    _retweetedScreenName.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedScreenName];
    //被转发微博的内容
    _retweetedText = [[UILabel alloc]init];
    _retweetedText.numberOfLines = 0;
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedText];
    //被转发微博的配图
    _retweetedImage = [[ImageListView alloc]init];
    [_retweeted addSubview:_retweetedImage];
}
#pragma mark 计算frame
- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    Status *status = cellFrame.status;
   
    //1.头像
    _icon.type =  kIconTypeSmall;
    _icon.frame = _cellFrame.iconFrame;
    _icon.user = status.user;
    //2.昵称
    _screenName.frame = _cellFrame.screenFrame;
    _screenName.text = status.user.screenName;
    if (status.user.mbtype == kMBTypeNone) {
        _screenName.textColor = [UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:1.0];
        _mbIcon.hidden = YES;
    }else{
        _screenName.textColor = [UIColor colorWithRed:243/255.0 green:101/255.0 blue:18/255.0 alpha:1.0];
        _mbIcon.hidden = NO;
        _mbIcon.frame = cellFrame.mbIconFrame;
    }
    //3.时间
    _time.text = status.createdAt;
    CGFloat timeX = cellFrame.screenFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(cellFrame.screenFrame) + kCellBorderWidth;
    CGSize timeSize = [_time.text sizeWithFont:kTimeFont];
    _time.frame =  (CGRect){{timeX,timeY},timeSize};
    //4.来源
    _source.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(_time.frame  ) + kCellBorderWidth;
    CGFloat sourceY =  timeY;
    CGSize sourceSize = [_source.text sizeWithFont:kSourceFont];
    _source.frame = (CGRect){{sourceX, sourceY},sourceSize};
    
    //5.内容
    _text.frame = cellFrame.textFrame;
    _text.text = status.text;
    //6.配图
    if (status.picUrls.count) {
        _image.hidden = NO;
        _image.frame = cellFrame.imageFrame;
        _image.imageUrls = status.picUrls;
        //        NSString *imageStr = status.picUrls[0][@"thumbnail_pic"];
        //        NSURL *imgURL = [NSURL URLWithString:imageStr];
        //        [_image setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"icon"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
        
    }else{
        _image.hidden = YES;
    }
    
    //7.被转发微博
    if (status.retweetedStatus) {
        _retweeted.hidden = NO;
        _retweeted.frame = cellFrame.retweetedFrame;
        //8.被转发微博的昵称
        _retweetedScreenName.frame = cellFrame.retweetedScreenNameFrame;
        
        _retweetedScreenName.text = [NSString stringWithFormat:@"@%@",status.retweetedStatus.user.screenName];
        
        //9.
        _retweetedText.frame = _cellFrame.retweetedTextFrame;
        _retweetedText.text = status.retweetedStatus.text;
        //10.配图
        if (status.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            _retweetedImage.frame = cellFrame.retweetedImageFrame;
            _retweetedImage.imageUrls = status.retweetedStatus.picUrls;
          #warning -------------------------
        }else{
            _retweetedImage.hidden = YES;
        }
    }else{
        _retweeted.hidden = YES;
    }
}
@end
