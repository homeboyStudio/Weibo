//
//  Dock.h
//  新浪微博
//
//  Created by homeboy on 14-9-3.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//  底部的工具条（选项卡条）

#import <UIKit/UIKit.h>

@class Dock;

@protocol DockDelegate <NSObject>
@optional
- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to;
@end

@interface Dock : UIView
// 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title;

// 代理
@property (nonatomic, weak) id<DockDelegate> delegate;

@property (nonatomic,assign)int selectedIndex;
@end