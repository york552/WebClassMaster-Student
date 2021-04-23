//
//  LoginViewController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/23.
//

#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "UIColor+Hex.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <BmobSDK/Bmob.h>

@interface LoginViewController ()
@property (nonatomic, strong)UILabel *topLabel;
@property (nonatomic, strong)UILabel *introLabel;
@property (nonatomic, strong)UITextField *account;
@property (nonatomic, strong)UITextField *password;
@property (nonatomic, strong)UIButton *changeButton;
@property (nonatomic, strong) MBProgressHUD *toastView;
@property (nonatomic, strong) UIWindow *window;
@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
    [self setUI];
}

#pragma mark - UI
- (void)setUI {
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.introLabel];
    [self.view addSubview:self.account];
    [self.view addSubview:self.password];
    [self.view addSubview:self.changeButton];
}

#pragma mark - lazy
- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(24, 128, 160, 28)];
        _topLabel.text = @"账号密码登录";
        _topLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
        _topLabel.textColor = UIColor.blackColor;
    }
    return _topLabel;
}

- (UILabel *)introLabel {
    if (!_introLabel) {
        _introLabel = [[UILabel alloc]initWithFrame:CGRectMake(24, 164, 200, 18)];
        _introLabel.text = @"使用老师提供的账号登陆";
        _introLabel.font = [UIFont systemFontOfSize:14];
        _introLabel.textColor = [UIColor colorWithHexString:@"#969799"];
    }
    return _introLabel;
}

- (UITextField *)account {
    if (!_account) {
        _account = [[UITextField alloc]initWithFrame:CGRectMake(24, 260, self.view.frame.size.width - 48, 44)];
        _account.placeholder = @"请输入账号";
        _account.backgroundColor = UIColor.whiteColor;
        _account.layer.cornerRadius = 8;
        _account.borderStyle = UITextBorderStyleRoundedRect;
        _account.layer.masksToBounds = YES;
    }
    return _account;
}

- (UITextField *)password {
    if (!_password) {
        _password = [[UITextField alloc]initWithFrame:CGRectMake(24, 328, self.view.frame.size.width - 48, 44)];
        _password.placeholder = @"请输入密码";
        _password.layer.cornerRadius = 8;
        _password.backgroundColor = UIColor.whiteColor;
        _password.layer.masksToBounds = YES;
        _password.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _password;
}

- (UIButton *)changeButton {
    if (!_changeButton) {
        _changeButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 396, self.view.frame.size.width - 24, 44)];
        _changeButton.layer.cornerRadius = 20;
        _changeButton.layer.masksToBounds = YES;
        [_changeButton setTitle:@"登录" forState:UIControlStateNormal];
        _changeButton.backgroundColor = UIColor.blackColor;
        [_changeButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeButton;
}

-(MBProgressHUD*) toastView{
    
    if (!_toastView) {
        _toastView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _toastView.minShowTime = 2;
        [_toastView setMode:MBProgressHUDModeText];
        _toastView.contentColor = [UIColor grayColor];
        _toastView.bezelView.backgroundColor = [UIColor blackColor];
    }
    return _toastView;
}

#pragma mark - action
- (void)buttonClick {
    [self inspectAccount:self.account.text withSecret:self.password.text];
}

-(void)getToastString:(NSString*)str{
    self.toastView.label.text = str;
    [self.toastView hideAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    self.toastView.completionBlock = ^{
        [weakSelf.toastView removeFromSuperview];
        weakSelf.toastView = nil;
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark - net

- (void)inspectAccount:(NSString *)account withSecret:(NSString *)secret {
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"StudentInfo"];
    MBProgressHUD *waitToast = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [waitToast showAnimated:YES];
    [bquery getObjectInBackgroundWithId:account block:^(BmobObject *object,NSError *error){
        [waitToast hideAnimated:YES];
        if (error){
            [self getToastString:@"未找到用户相关信息"];
        }else{
            if (object) {
                if ([secret isEqual:[object objectForKey:@"secret"]]) {
                    [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"USER_ACCOUNT_ID"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"name"] forKey:@"USER_ACCOUNT_NAME"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"num"] forKey:@"USER_ACCOUNT_NUM"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"major"] forKey:@"USER_ACCOUNT_MAJOR"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"studentClass"] forKey:@"USER_ACCOUNT_CLASS"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"GPA"] forKey:@"USER_ACCOUNT_GPA"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"gender"] forKey:@"USER_ACCOUNT_GENDER"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"telephone"] forKey:@"USER_ACCOUNT_TEL"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"secret"] forKey:@"USER_ACCOUNT_SECRET"];
                    [[NSUserDefaults standardUserDefaults] setObject:[object objectForKey:@"age"] forKey:@"USER_ACCOUNT_AGE"];
                    [self getToastString:@"登陆成功"];
                    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
                    MainTabBarController * tabBarController = [[MainTabBarController alloc]init];
                    self.window.rootViewController = tabBarController;
                    [self.window makeKeyAndVisible];
                } else {
                    [self getToastString:@"密码错误"];
                }
            }
        }
    }];
}
@end
