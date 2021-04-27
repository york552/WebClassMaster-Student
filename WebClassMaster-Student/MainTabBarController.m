//
//  MainTabBarController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/21.
//

#import "MainTabBarController.h"
#import "EntryRoomController.h"
#import "SettingMainController.h"
#import "ClassViewController.h"

@interface MainTabBarController ()
@property (nonatomic, strong) UIWindow *classroomWindow;
@property (nonatomic, strong) UINavigationController *nav1;
@property (nonatomic, strong) UINavigationController *nav2;
@property (nonatomic, strong) UINavigationController *nav3;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *librayPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
//    NSLog(@"libraryPath:%@",librayPath);
    [self setUI];
}

// MARK:UI
- (void)setUI{
    self.viewControllers = @[self.nav1,self.nav2,self.nav3];
    self.tabBar.tintColor = UIColor.blackColor;
}

// MARK:lazy
- (UINavigationController *)nav1 {
    if (!_nav1) {
        _nav1 = [[UINavigationController alloc] initWithRootViewController:[[EntryRoomController alloc]init]];
        _nav1.tabBarItem.image = [UIImage imageNamed:@"Classroom_tabIcon"];
        _nav1.tabBarItem.title = @"上课";
    }
    return _nav1;
}

- (UINavigationController *)nav2 {
    if (!_nav2) {
        _nav2 = [[UINavigationController alloc] initWithRootViewController:[[ClassViewController alloc]init]];
        _nav2.tabBarItem.image = [UIImage imageNamed:@"Replay_tabIcon"];
        _nav2.tabBarItem.title = @"课程";
    }
    return _nav2;
}

- (UINavigationController *)nav3{
    if (!_nav3) {
        _nav3 = [[UINavigationController alloc]initWithRootViewController:[[SettingMainController alloc]init]];
        _nav3.tabBarItem.image = [UIImage imageNamed:@"Set_tabIcon"];
        _nav3.tabBarItem.title = @"设置";
    }
    return _nav3;
}

@end

