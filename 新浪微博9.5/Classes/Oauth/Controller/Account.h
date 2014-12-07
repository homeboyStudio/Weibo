//
//  Account.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-17.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property (nonatomic,copy)NSString *accessToken;
@property (nonatomic,copy)NSString *uid;
@end
