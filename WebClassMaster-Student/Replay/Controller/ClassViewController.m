//
//  ClassViewController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/23.
//

#import "ClassViewController.h"
#import "ChooseClassViewController.h"
#import "ClassInfoViewController.h"

@interface ClassViewController ()
@property (nonatomic, strong)UITableView *classListTableView;
@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"回放";
    [self setUI];
}

#pragma mark -UI
- (void)setUI {
    
}
#pragma mark -lazy


@end
