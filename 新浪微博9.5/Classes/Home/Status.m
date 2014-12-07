 //
//  Status.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "Status.h"

@implementation Status
- (id)initWithDit:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.ID = [dict[@"id"] longLongValue];
        self.text = dict[@"text"];
        self.user = [[User alloc]initWithDit: dict[@"user"]];
        self.picUrls = dict[@"pic_urls"];
        
        
        NSDictionary *retweeted = dict[@"retweeted_status"];
        //如果是转发微博创建一个新的微博对象并初始化 
        if (retweeted) {
            self.retweetedStatus = [[Status alloc]initWithDit:retweeted];
        }
        self.createdAt = dict[@"created_at"];
        self.source = dict[@"source"];
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
         
    }
    return self;
}
- (NSString *)createdAt
{
    // Sat Nov 02 15:08:27 +0800 2014
    //1.将新浪时间字符串转为NSDate对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_createdAt];
    //2.将NSDate跟当前时间比较，生成合理字符串
    NSDate *now = [NSDate date];
    //时间间隔
   NSTimeInterval delta =  [now timeIntervalSinceDate:date];
    
    if (delta < 60) {   //1分钟内
        return @"刚刚";
    }else if(delta < 60 * 60){     //1小时内
        return [NSString stringWithFormat:@"%.0f分钟前",delta/60];
    }else if (delta < 60 * 60 *24){   //1天内
        return [NSString stringWithFormat:@"%.0f小时前",delta/60/60];
    }else{
    fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
}
- (NSString *)source
{
//    int begin = [_source rangeOfString:@">"].location + 1;
//    int end  = [_source rangeOfString:@"</"].location;
//   return [NSString stringWithFormat:@"来自%@",[_source substringWithRange:NSMakeRange(begin, end - begin)]];
    return @"来自微博weibo.com";
}
@end
