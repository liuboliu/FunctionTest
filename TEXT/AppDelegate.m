//
//  AppDelegate.m
//  TEXT
//
//  Created by 刘博 on 2019/10/17.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController3.h"
#import "ViewController.h"
#import "ViewController4.h"
#import "ViewController6.h"
#import "ViewController8.h"
#import "ViewController5.h"
#import "ViewController2.h"
#import "ViewControllerEnumObject.h"
#import "ViewControllerNotification.h"
#import "ViewControllerSegment.h"
#import "ViewControllerLayoutSubviews.h"
#import "ViewControllerUserSaveModel.h"
#import "ViewControllerDecorationView.h"
#import "TableViewController.h"
#import "HeaderExpandViewController.h"
#import "VVVVV.h"
#import <JLRoutes/JLRoutes.h>
#import "LBBaseViewController.h"
#import "AttributedStringViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   // self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TableViewController *vc = [[TableViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navi;
//    VVVVV * v = [[VVVVV alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    v.backgroundColor = [UIColor cyanColor];
//
//    [self.window addSubview:v];
    [self.window makeKeyAndVisible];


    [[JLRoutes routesForScheme:@"liubolink"] addRoute:@":vc" priority:0 handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        void (^compleBlock)(void) = parameters[@"completionBlock"];
        if (compleBlock) {
            compleBlock();
        }
        UINavigationController *navigationVC = (UINavigationController * )([UIApplication sharedApplication].keyWindow.rootViewController);
        NSString *className = parameters[@"vc"];
        LBBaseViewController *vc = [[NSClassFromString(className) alloc] init];
        vc.parameter = parameters;
        [navigationVC pushViewController:vc animated:YES];
        return YES;
    }];
    
    [[JLRoutes routesForScheme:@"liubolink"] addRoute:@"liubo" priority:1 handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        AttributedStringViewController *vc = [[AttributedStringViewController alloc] init];
        UINavigationController *navigationVC = (UINavigationController * )([UIApplication sharedApplication].keyWindow.rootViewController);
        [navigationVC pushViewController:vc animated:YES];
        return YES;
    }];
    
    [[JLRoutes routesForScheme:@"liubolink"] addRoute:@":vc" priority:0 handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSLog(@"哈哈哈执行执行执行");
        return YES;
    }];
    
 
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
