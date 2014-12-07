//
//  ImageListView.h
//  新浪微博9.5
//
//  Created by homeboy on 14-10-3.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//   配图列表（1~9张）

#import <UIKit/UIKit.h>

@interface ImageListView : UIView
@property (nonatomic,strong) NSArray *imageUrls;
+ (CGSize)imageListSizeWithCount:(NSUInteger)count;
@end
