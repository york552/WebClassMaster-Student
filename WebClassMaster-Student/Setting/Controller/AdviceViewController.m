//
//  AdviceViewController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/22.
//

#import "AdviceViewController.h"
#import "UIColor+Hex.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <BmobSDK/Bmob.h>

@interface AdviceViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *adviceText;
@property (nonatomic, strong) UIButton *adviceButton;
@property (nonatomic, strong) MBProgressHUD* toastView;//弹出提示
@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
    [self setUI];
}

#pragma mark - UI
- (void)setUI {
    [self.view addSubview:self.adviceText];
    [self.view addSubview:self.adviceButton];
}

#pragma mark - lazy
- (UITextView *)adviceText {
    if (!_adviceText) {
        _adviceText = [[UITextView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height + 12, self.view.frame.size.width, 220)];
        _adviceText.backgroundColor = UIColor.whiteColor;
        _adviceText.textColor = UIColor.grayColor;
        _adviceText.text = @"请输入你要反馈的意见";
        _adviceText.textContainerInset = UIEdgeInsetsMake(10, 16, 0, 16);
        _adviceText.delegate = self;
    }
    return _adviceText;
}

- (UIButton *)adviceButton {
    if (!_adviceButton) {
        _adviceButton = [[UIButton alloc]initWithFrame:CGRectMake(12, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height + 260, self.view.frame.size.width - 24, 40)];
        _adviceButton.layer.cornerRadius = 20;
        _adviceButton.layer.masksToBounds = YES;
        [_adviceButton setTitle:@"提交" forState:UIControlStateNormal];
        _adviceButton.backgroundColor = UIColor.blackColor;
        [_adviceButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _adviceButton;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请输入你要反馈的意见";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入你要反馈的意见"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
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

#pragma mark - Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)buttonClick {
    NSString *num = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_NUM"];
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ACCOUNT_NAME"];
    BmobObject *gameScore = [BmobObject objectWithClassName:@"Advice"];
    [gameScore setObject:num forKey:@"num"];
    [gameScore setObject:name forKey:@"name"];
    [gameScore setObject:self.adviceText.text forKey:@"advice"];
    MBProgressHUD *waitToast = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [waitToast showAnimated:YES];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        [waitToast hideAnimated:YES];
        [self getToastString:@"提交成功，感谢您的反馈"];
    }];
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
@end
