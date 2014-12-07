//
//  Status.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Status : NSObject
@property (nonatomic,assign)long long ID;
@property (nonatomic,copy)NSString *text;
@property (nonatomic,strong)User *user;
@property (nonatomic,copy)NSArray *picUrls;          //微博配图
@property (nonatomic,strong)Status *retweetedStatus; //被转发的微博
@property (nonatomic,copy)NSString *createdAt;       //微博创建时间
@property (nonatomic,assign)int repostsCount;	     //转发数
@property (nonatomic,assign)int commentsCount;		 //评论数
@property (nonatomic,assign)int attitudesCount;	     //表态数  赞
@property (nonatomic,copy)NSString *source;	         //微博来源

- (id)initWithDit:(NSDictionary *)dict;

@end
