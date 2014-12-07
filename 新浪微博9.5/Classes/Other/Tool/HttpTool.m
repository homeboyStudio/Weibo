 //
//  HttpTool.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-18.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
@implementation HttpTool
+ (void)requestWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params succcess:(HttpSuccessBlock)success failure:(HttpfailureBlock)failure method:(NSString *)method
{
    //1.创建post请求;
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:baseURL]];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    //拼接传进来的参数，不能为空拼接nil，同下
    if (allParams) {
        [allParams setDictionary:params];
    }
    //判断，拼接token参数
    NSString *token =[AccountTool shareAccountTool].currentAccount.accessToken;
    if (token) {
        [allParams  setObject:token forKey:@"access_token"];
    }
    
    NSURLRequest *post = [client requestWithMethod:method path:path parameters:allParams];
    //2.发送post请求
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:post success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
         if (success == nil) return;
        //如果成功传入JSON
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
         if (failure == nil) return;
        failure (error);
    }];
    //3.发送请求
    [op start];
}
+ (void)postWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params succcess:(HttpSuccessBlock)success failure:(HttpfailureBlock)failure
{
    [self requestWithBaseURL:baseURL path:path params:params succcess:success failure:failure method:@"POST"];
}
+ (void)getWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params succcess:(HttpSuccessBlock)success failure:(HttpfailureBlock)failure
{
    [self requestWithBaseURL:baseURL path:path params:params succcess:success failure:failure method:@"GET"];
}

+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}
@end
