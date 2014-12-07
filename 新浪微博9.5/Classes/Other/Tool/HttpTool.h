//
//  HttpTool.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-18.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  网络请求工具(异步调用)

#import <Foundation/Foundation.h>
typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpfailureBlock)(NSError *error);

@interface HttpTool : NSObject
//POST请求
+ (void)postWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params succcess:(HttpSuccessBlock)success failure:(HttpfailureBlock)failure;
//GET请求
+ (void)getWithBaseURL:(NSString *)baseURL path:(NSString *)path params:(NSDictionary *)params succcess:(HttpSuccessBlock)success failure:(HttpfailureBlock)failure;

+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView;
@end

