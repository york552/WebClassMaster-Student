//
//  ClassroomNavigationController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/22.
//

#import "ClassroomNavigationController.h"

@interface ClassroomNavigationController ()

@end

@implementation ClassroomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
