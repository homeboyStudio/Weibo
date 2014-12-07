//
//  ImageListView.m
//  新浪微博9.5
//
//  Created by homeboy on 14-10-3.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "ImageListView.h"
#import "UIImageView+WebCache.h"
//#import "ImageItemView.h"
#define kCount 9
#define kOneW 120
#define kOneH 120
#define kMultiW 80
#define kMultiH 80
#define kMargin 10
@implementation ImageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //把有可能显示的图片先都加进去
        for (int i = 0; i < kCount; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    unsigned long count = imageUrls.count;
    for (int i = 0; i < kCount; i++) {
        //1.取出对应位置的子控件
        UIImageView *child = self.subviews[i];
                //2.判断是否显示图片
        if (i >= count) { //不要显示图片
            child.hidden = YES;
        }else{
            child.hidden = NO;
            //3.设置显示的图片的地址
//            child.url = imageUrls[i][@"thumbnail_pic"];
            [child setImageWithURL:[NSURL URLWithString:imageUrls[i][@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"icon"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
            //4.设置frame
            if (count == 1) {
                child.contentMode = UIViewContentModeScaleAspectFit;
                child.frame = CGRectMake(0, 0, kOneW, kOneH);
            }else{
                child.contentMode = UIViewContentModeScaleAspectFill;
                //超出边界部分的减掉
                child.clipsToBounds = YES;
                int temp = (count == 4) ? 2 : 3;
                CGFloat row = i/temp;     //行号
                CGFloat column = i%temp;  //列号
                CGFloat x = (kMultiW + kMargin) *column;
                CGFloat y = (kMultiH + kMargin) *row;
                child.frame = CGRectMake(x, y, kMultiW, kMultiH);
            }
        }
    }
}
+ (CGSize)imageListSizeWithCount:(NSUInteger)count
{
    if (count == 1) {
        return CGSizeMake(kOneW,kOneH);
    }
    CGFloat countRow = (count == 4) ? 2: 3;
    //总行数
    int rows = (count + countRow - 1)/countRow;
    //总列数
    int columns = (count >= 3) ? 3:2;
    CGFloat width = columns * kMultiW + (columns - 1) * kMargin;
    CGFloat hight = rows * kMultiH + (rows - 1) * kMargin;
    return CGSizeMake(width, hight);
}
@end
