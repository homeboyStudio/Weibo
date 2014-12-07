 //
//  User.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "User.h"

@implementation User
- (id)initWithDit:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.screenName = dict[@"screen_name"];
        self.profileImageUrl = dict[@"profile_image_url"];
        self.verified = [dict[@"verified"] boolValue];
        self.verifiedType = [dict[@"verified_type"] intValue];
        self.mbrank = [dict[@"mbrank"] intValue];
        self.mbtype = [dict[@"mbtype"] intValue];
    }
    return self;
} 
@end
