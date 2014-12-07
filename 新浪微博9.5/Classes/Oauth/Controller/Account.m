//
//  Account.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-17.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "Account.h"

@implementation Account
#pragma mark - 归档调用
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_accessToken forKey:@"accessToken"];
    [encoder encodeObject:_uid forKey:@"uid"];
}
-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
