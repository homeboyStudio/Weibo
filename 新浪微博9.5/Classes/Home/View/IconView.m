//
//  IconView.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-29.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "IconView.h"
#import "HttpTool.h"


@interface IconView()
{
    UIImageView *_icon;     //头像图片
    UIImageView *_vertify;  //认证图标
    
    NSString *_placehoder;  //占位图片
}
@end
@implementation IconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       //.1用户的头像文件
        UIImageView *icon = [[UIImageView alloc]init];
        [self addSubview:icon];
        _icon = icon;
        //2.添加右下角认证图标
        UIImageView *vertify = [[UIImageView alloc]init];
        [self addSubview:vertify];
        _vertify = vertify;
    }
    return self;
}
#pragma 设置模型数据
- (void)setUser:(User *)user
{
    _user = user;
    //设置用户头像图片
       [HttpTool downloadImage:user.profileImageUrl place:[UIImage imageNamed:_placehoder] imageView:_icon];
    //设置认证图标
    switch (user.verifiedType) {
        case kVerifiedTypeNone:
            _vertify.hidden = YES;
            break;
            case kVerifiedTypeDaren:   //微博达人
            _vertify.hidden = NO;
            _vertify.image = [UIImage imageNamed:@"avatar_grassroot.png"];
            break;
            case kVerifiedTypePersonal:   //个人
            _vertify.hidden = NO;
            _vertify.image = [UIImage imageNamed:@"avatar_vip.png"];
            break;
        default:
            _vertify.hidden = NO;
            _vertify.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
    }
}
#pragma 设置图标的类型
-(void)setType:(IconType)type
{
    _type = type;
    switch (type) {
        case kIconTypeSmall:
            _icon.frame = CGRectMake(0, 0, kIconSmellWidth, kIconSmellHeight);
            _vertify.bounds = CGRectMake(0, 0, kVertifyWidth, kVertifyHeight);
            _vertify.center = CGPointMake(kIconSmellWidth, kIconSmellHeight);
            _placehoder = @"avatar_default_small.png";
            break;
        case kIconTypeDefault:
            _icon.frame = CGRectMake(0, 0, kIconDefaultWidth, kIconDefaultHeight);
            _vertify.bounds = CGRectMake(0, 0, kVertifyWidth, kVertifyHeight);
            _vertify.center = CGPointMake(kIconDefaultWidth, kIconDefaultHeight);
            _placehoder = @"avatar_default.png";
            break;
        case kIconTypeBig:
            _icon.frame = CGRectMake(0, 0, kIconBigWidth, kIconBigHeight);
            _vertify.bounds = CGRectMake(0, 0, kVertifyWidth, kVertifyHeight);
            _vertify.center = CGPointMake(kIconBigWidth, kIconBigHeight);
            _placehoder = @"avatar_default_big.pngi";
            break;
         }
    //3.自己的宽高
    self.bounds = CGRectMake(0, 0, _icon.frame.size.width + kVertifyWidth*0.5, _icon.frame.size.height + kVertifyHeight*0.5);
}
+ (CGSize)iconWithTyper:(IconType)iconType
{
    CGSize iconSize;
    switch (iconType) {
        case kIconTypeSmall:
            iconSize = CGSizeMake(kIconSmellWidth, kIconSmellHeight);
                       break;
        case kIconTypeDefault:
            iconSize = CGSizeMake(kIconDefaultWidth, kIconDefaultHeight);
            break;
        case kIconTypeBig:
            iconSize = CGSizeMake(kIconBigWidth, kIconBigHeight);
            break;
    }
    //3.自己的宽高
    CGFloat width = iconSize.width + 0.5*kVertifyWidth;
    CGFloat height = iconSize.height + 0.5*kVertifyHeight;
    return CGSizeMake(width,height);

}
//- (void)setFrame:(CGRect)frame
//{
//    frame.size = self.bounds.size;
//    [super setFrame:frame];
//}
@end
