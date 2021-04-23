//
//  ChangepasswordViewController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/23.
//

#import "ChangePasswordViewController.h"
#import "UIColor+Hex.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <BmobSDK/Bmob.h>

@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *oldpassword;
@property (nonatomic, strong)UITextField *password;
@property (nonatomic, strong)UIButton *changeButton;
@property (nonatomic, strong) MBProgressHUD *toastView;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更改密码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
    [self setUI];
}

#pragma mark - UI
- (void)setUI {
    [self.view addSubview:self.oldpassword];
    [self.view addSubview:self.password];
    [self.view addSubview:self.changeButton];
}

#pragma mark - lazy
- (UITextField *)oldpassword {
    if (!_oldpassword) {
        _oldpassword = [[UITextField alloc]initWithFrame:CGRectMake(30, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height + 50, self.view.frame.size.width - 60, 40)];
        _oldpassword.placeholder = @"请输入旧密码";
        _oldpassword.backgroundColor = UIColor.whiteColor;
        _oldpassword.layer.cornerRadius = 8;
        _oldpassword.layer.masksToBounds = YES;
        _oldpassword.delegate = self;
    }
    return _oldpassword;
}

- (UITextField *)password {
    if (!_password) {
        _password = [[UITextField alloc]initWithFrame:CGRectMake(30, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height + 102, self.view.frame.size.width - 60, 40)];
        _password.placeholder = @"请输入旧密码";
        _password.layer.cornerRadius = 8;
        _password.backgroundColor = UIColor.whiteColor;
        _password.layer.masksToBounds = YES;
        _password.delegate = self;
    }
    return _password;
}

- (UIButton *)changeButton {
    if (!_changeButton) {
        _changeButton = [[UIButton alloc]initWithFrame:CGRectMake(12, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height + 200, self.view.frame.size.width - 24, 40)];
        _changeButton.layer.cornerRadius = 20;
        _changeButton.layer.masksToBounds = YES;
        [_changeButton setTitle:@"修改" forState:UIControlStateNormal];
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
    NSString *num = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_SECRET"];
    if ([num isEqual:self.oldpassword.text]) {
        [self changePassword:self.password.text];
    } else {
        [self getToastString:@"原密码不正确"];
    }
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
- (void)changePassword:(NSString *)password {
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"StudentInfo"];
    MBProgressHUD *waitToast = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [waitToast showAnimated:YES];
    [bquery getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_ID"] block:^(BmobObject *object,NSError *error){
        [waitToast hideAnimated:YES];
        if (!error) {
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                [obj1 setObject:password forKey:@"secret"];
                [obj1 updateInBackground];
                [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"USER_ACCOUNT_SECRET"];
                [self getToastString:@"修改完成"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }else{
            [self getToastString:@"未找到用户相关信息"];
        }
    }];
}
@end
