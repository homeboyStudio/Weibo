//
//  User.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-21.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    kVerifiedTypeNone = -1,
    kVerifiedTypePersonal = 0,
    kVerifiedTypeOrgEnterprice = 2,   //企业官方
    kVerifiedTypeOrgMedia = 3,        //媒体官方
    kVerifiedTypeOrgWebsite = 5,      //网站官方
    kVerifiedTypeDaren = 220
}VerifiedType;

typedef enum {
    kMBTypeNone =0,
    kMBTypeNormal,
    kMBTypeYear
}MBType;
@interface User : NSObject
@property (nonatomic,copy)NSString *screenName;   //昵称
@property (nonatomic,copy)NSString *profileImageUrl; //用户头像
@property (nonatomic,assign)BOOL verified; 		//是否是微博认证用户，即加V用户，true：是，false：否
@property (nonatomic,assign)VerifiedType verifiedType;   //认证类型
@property (nonatomic,assign)int mbrank;
@property (nonatomic,assign)MBType mbtype;
- (id)initWithDit:(NSDictionary *)dict; 
@end
