//
//  AppDelegate.m
//  ExampleDemo
//
//  Created by 李罗坚 on 2020/5/21.
//  Copyright © 2020 李罗坚. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    IndexVC *indexVC = [[IndexVC alloc]init];
    self.window.rootViewController = indexVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
