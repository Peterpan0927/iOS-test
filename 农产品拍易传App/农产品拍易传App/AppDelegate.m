//
//  AppDelegate.m
//  农产品拍易传App
//
//  Created by 潘振鹏 on 2017/9/7.
//  Copyright © 2017年 潘振鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "LeftMenuController.h"
#import "LoginViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor greenColor];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //创建箭头指向控制器
    UIViewController *loginVc = [sb instantiateViewControllerWithIdentifier:@"login"];;
    //创建主控制器

    self.window.rootViewController = loginVc;
    
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginSuccess) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Logout) name:@"LogoutSuccess" object:nil];
    // Override point for customization after application launch.
    return YES;
}

- (void)LoginSuccess{
    //左边的个人菜单控制器
    LeftMenuController *leftViewController = [[LeftMenuController alloc] init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //创建箭头指向控制器
    UINavigationController *navVc = sb.instantiateInitialViewController;
    //创建主控制器
    
    self.window.rootViewController = [DrawerViewController drawerVcWithMainVc:navVc leftMenuVc:leftViewController leftWidth:300 ];
    
}

- (void)Logout{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //创建箭头指向控制器
    UIViewController *loginVc = [sb instantiateViewControllerWithIdentifier:@"login"];;
    //创建主控制器
    
    self.window.rootViewController = loginVc;
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
