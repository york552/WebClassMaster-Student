//
//  SettingMainController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/22.
//

#import "SettingMainController.h"
#import "LoginViewController.h"
#import "EyesProtectViewCell.h"
#import "AdviceViewController.h"
#import "ChangePasswordViewController.h"
#import "MineDetailViewController.h"
#import "UIColor+Hex.h"

@interface SettingMainController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *setTableView;
@property (nonatomic, strong) UIButton *quitButton;
@property (nonatomic, strong) NSArray<NSArray*> *cellDataSourceArray;
@property (nonatomic, strong) UIWindow *window;
@end

@implementation SettingMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
    self.navigationItem.title = @"设置";
    [self setUI];
}

- (void)setUI {
    [self.view addSubview:self.setTableView];
    [self.view addSubview:self.quitButton];
}

#pragma mark -lazy
- (UITableView *)setTableView {
    if (!_setTableView) {
        _setTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, 240) style:UITableViewStyleGrouped];
        _setTableView.delegate = self;
        _setTableView.dataSource = self;
        [_setTableView setScrollEnabled:NO];
        [_setTableView registerClass:[EyesProtectViewCell class] forCellReuseIdentifier:NSStringFromClass([EyesProtectViewCell class])];
        [_setTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];


    }
    return _setTableView;
}

- (NSArray *)cellDataSourceArray {
    if (!_cellDataSourceArray) {
        _cellDataSourceArray = @[@[@"护眼模式"],@[@"我的信息",@"更改密码"],@[@"意见反馈"]];
    }
    return _cellDataSourceArray;
}

- (UIButton *)quitButton {
    if (!_quitButton) {
        _quitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 260 + self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, 48)];
        _quitButton.backgroundColor = UIColor.whiteColor;
        [_quitButton setTitle:@"退出" forState:UIControlStateNormal];
        [_quitButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_quitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitButton;
}

#pragma mark -action
- (void)quit {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LoginViewController *vc = [[LoginViewController alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

#pragma mark -delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *tempId = @"";
    if (indexPath.section == 0) {
        tempId = NSStringFromClass([EyesProtectViewCell class]);
    } else {
        tempId = @"cell";
    }
    UITableViewCell *cell = [self.setTableView dequeueReusableCellWithIdentifier:tempId];
    if (indexPath.section != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.cellDataSourceArray[indexPath.section][indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowArray = self.cellDataSourceArray[section];
    return rowArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellDataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
    return footView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1 && indexPath.row == 0) {
        MineDetailViewController *vc = [[MineDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        ChangePasswordViewController *vc = [[ChangePasswordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        AdviceViewController *vc = [[AdviceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
