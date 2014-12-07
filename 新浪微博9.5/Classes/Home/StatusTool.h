//
//  StatusTool.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>
//statuses装的都是Statuses对象
typedef void (^StatusSuccessBlock)(NSArray *statuses);
typedef void (^StatusFailureBlock)(NSError *error);
@interface StatusTool : NSObject
+ (void)statusesWithSinceID:(long long)sinceId maxID:(long long)maxId Success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;

@end
