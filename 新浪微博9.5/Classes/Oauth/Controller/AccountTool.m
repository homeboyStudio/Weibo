//
//  AccountTool.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-17.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "AccountTool.h"
//文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingFormat:@"account.data"] 
@implementation AccountTool
static AccountTool *_instance;
+(AccountTool *)shareAccountTool
{
    if (_instance == nil) {
        _instance = [[self alloc]init];
    }
    return _instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)init
{
    if (self = [super init]) {
      
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}
- (void)saveAccount:(Account *)account
{
    _currentAccount = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}
@end
