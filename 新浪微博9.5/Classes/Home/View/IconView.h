//
//  IconView.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-29.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//
#define kIconSmellWidth 34
#define kIconSmellHeight 34
#define kIconDefaultWidth 50
#define kIconDefaultHeight 50
#define kIconBigWidth 85
#define kIconBigHeight 85
#define kVertifyWidth 18
#define kVertifyHeight 18

#import <UIKit/UIKit.h>
#import "User.h"
typedef enum{
    kIconTypeSmall,
    kIconTypeDefault,
    kIconTypeBig
}IconType;
@interface IconView : UIView
@property (strong,nonatomic)User *user;

@property (nonatomic,assign)IconType type;

+ (CGSize)iconWithTyper:(IconType)iconType;
@end
