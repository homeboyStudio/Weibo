//
//  UIImage+HomeboyAdd.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-6.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "UIImage+HomeboyAdd.h"

@implementation UIImage (HomeboyAdd)
#pragma mark - 加载全屏的图片
+ (UIImage *)fullscreenImage:(NSString *)imgName
{
    //1.如果是iphone5+
    if (iPhone5) {
        imgName = [imgName stringByAppendingFormat:@"-568h@2x"];
//        imgName = [imgName fileAppend:@"-568h@2x"];
        //获得文件的扩展名
//        NSString *ext = [imgName pathExtension];
//        imgName = [imgName stringByDeletingPathExtension];
//        imgName = [[imgName stringByAppendingFormat:@"-568h@2x"]stringByAppendingPathExtension:ext];
//        return imgName;
    }
    return [self imageNamed:imgName];
}
+ (UIImage *)resizedImage:(NSString *)imgNamge
{
    UIImage *image = [UIImage imageNamed:imgNamge];
 return  [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}
+ (UIImage *)resizedImage:(NSString *)imgNamge xPos:(CGFloat)x yPos:(CGFloat)y
{
    UIImage *image = [UIImage imageNamed:imgNamge];
    return  [image stretchableImageWithLeftCapWidth:image.size.width*x topCapHeight:image.size.height*y];
}
@end
