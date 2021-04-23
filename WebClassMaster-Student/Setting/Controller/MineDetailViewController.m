//
//  MineDetailViewController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/23.
//

#import "MineDetailViewController.h"
#import "MineDetailTableViewCell.h"
#import "UIColor+Hex.h"
#import <Masonry/Masonry.h>

@interface MineDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *introArray;
@end

@implementation MineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    self.view.backgroundColor = [UIColor colorWithHex:0xF7F8FA];
    self.introArray = @[@"姓名",@"学号",@"年龄",@"性别",@"专业",@"班级",@"绩点",@"电话"];
    [self setUI];
}

#pragma mark -UI
- (void)setUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(12);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width - 24, 416));
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark -Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.layer.cornerRadius = 6;
        _tableView.layer.masksToBounds = YES;
        _tableView.allowsSelection = NO;
        [_tableView setScrollEnabled:NO];
        [_tableView registerClass:[MineDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineDetailTableViewCell class])];
    }
    return _tableView;
}

#pragma mark -Delegate && DataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MineDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineDetailTableViewCell class])];
    if (indexPath.row == 0) {
        cell.leftText = @"姓名";
        cell.rightText = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_NAME"];
    } else if (indexPath.row == 1) {
        cell.leftText = @"学号";
        cell.rightText = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_NUM"];
    } else if (indexPath.row == 2) {
        cell.leftText = @"年龄";
        cell.rightText = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_AGE"];
    } else if (indexPath.row == 3) {
        cell.leftText = @"性别";
        cell.rightText = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_GENDER"];
    } else if (indexPath.row == 4) {
        cell.leftText = @"专业";
        cell.rightText = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_MAJOR"];
    } else if (indexPath.row == 5) {
        cell.leftText = @"班级";
        cell.rightText = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_CLASS"];
    } else if (indexPath.row == 6) {
        cell.leftText = @"绩点";
        cell.rightText = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_GPA"];
    } else if (indexPath.row == 7) {
        cell.leftText = @"电话";
        cell.rightText = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_TEL"];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}
@end
