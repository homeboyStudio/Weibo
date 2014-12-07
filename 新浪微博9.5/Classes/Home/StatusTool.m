//
//  StatusTool.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//
#define kAppKey @"431315585"
#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define kAppSecret @"53919843fa900956260731bf1e99d6db"
#define kOauthrize @"https://api.weibo.com/oauth2/authorize"
#define kBaseURL  @"https://api.weibo.com"

#import "StatusTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Status.h"
@implementation StatusTool
+ (void)statusesWithSinceID:(long long)sinceId maxID:(long long)maxId Success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure
{
    [HttpTool getWithBaseURL:kBaseURL path:@"2/statuses/home_timeline.json" params:@{
    @"count":@3,
    @"since_id":@(sinceId),
    @"max_id":@(maxId)
    } succcess:^(id JSON) {
        
        //解析JSON 对象
        NSArray *array = JSON[@"statuses"];
        NSMutableArray *statuses = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            Status *s = [[Status alloc]initWithDit:dic];
            [statuses addObject:s];
        }
        //回调block
        success(statuses);
               } failure:^(NSError *error) {
                    if (failure == nil) return;
                   failure(error);
    }];

}
@end
