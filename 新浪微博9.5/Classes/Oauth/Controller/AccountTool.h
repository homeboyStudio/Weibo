//
//  AccountTool.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-17.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  管理账号信息

#import <Foundation/Foundation.h>
#import "Account.h"
@interface AccountTool : NSObject

+(AccountTool *)shareAccountTool;

//获得当前账号
@property (nonatomic,readonly)Account *currentAccount;
- (void)saveAccount:(Account *)account;
@end
