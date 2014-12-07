//
//  DockController.h
//  新浪微博
//
//  Created by homeboy on 14-9-3.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
#import <UIKit/UIKit.h>
#import "Dock.h"

@interface DockController : UIViewController
{
    Dock *_dock;
}
@property (nonatomic,readonly)UIViewController *selectedController;

@end
