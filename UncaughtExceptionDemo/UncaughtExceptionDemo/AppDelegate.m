//
//  AppDelegate.m
//  UncaughtExceptionDemo
//
//  Created by 王海鹏 on 2020/7/16.
//  Copyright © 2020 王海鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "UncaughtExceptionHandler.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    InstallUncaughtExceptionHandler();
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [ViewController new];

    return YES;
}
@end
