//
//  HBAppDelegate.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-5.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "HBAppDelegate.h"
#import "NewfeatureController.h"
#import "MainController.h"
#import "OauthController.h"
#import "AccountTool.h" 
@implementation HBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //---------------------判断是否第一次使用该版本，之后进行操作
    NSString *key = (NSString *)kCFBundleVersionKey;
        //1.从info的plist文件中取出的版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
       //2.从沙盒里取出的上次存储的版本号
    NSString *saveVersion =  [[NSUserDefaults standardUserDefaults]objectForKey:key];
    if ([version isEqualToString:saveVersion]) {  //不是第一次使用该版本
        application.statusBarHidden = NO;
        //是否授权了新浪微博的登录
        if ([AccountTool shareAccountTool].currentAccount) {
            self.window.rootViewController = [[MainController alloc]init];
        }else{
            self.window.rootViewController = [[OauthController alloc]init];
        }
    }else{     //版本号不一样  第一次使用新版本
               //将新版本写入沙盒
        [[NSUserDefaults standardUserDefaults]setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
               //显示版本新特性
        self.window.rootViewController = [[NewfeatureController alloc]init];
        
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
