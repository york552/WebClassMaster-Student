//
//  AppDelegate.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/21.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import <BmobSDK/Bmob.h>
#import "ClassroomNavigationController.h"
#import "EntryRoomController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Bmob registerWithAppKey:@"263ca60ec151c73cb603cc1409b74da6"];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    MainTabBarController * tabBarController = [[MainTabBarController alloc]init];
        
    self.window.rootViewController = [[EntryRoomController alloc] init];// [[ClassroomNavigationController alloc] initWithRootViewController:[EntryRoomController new]];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
