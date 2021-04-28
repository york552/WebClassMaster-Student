//
//  EntryRoomController.m
//  网课通教师版
//
//  Created by 约克 on 2021/3/16.
//

#import "EntryRoomController.h"
#import "HWDownSelectedView.h"
#import "YKTool.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <AgoraEduSDK/AgoraEduSDK.h>
@interface EntryRoomController ()<AgoraEduClassroomDelegate, AgoraEduReplayDelegate, HWDownSelectedViewDelegate>
@property (nonatomic, strong) UIButton *enterButtom;
@property (nonatomic, strong) UITextField *roomNameTextField;
@property (nonatomic, strong) HWDownSelectedView *roomTypeSelectView;
@property (nonatomic, strong) MBProgressHUD *toastView;//弹出提示
@property (nonatomic, assign) NSString *roomName;
@property (nonatomic, assign) AgoraEduRoomType classType;

@end

@implementation EntryRoomController

- (void)viewDidLoad {
    [super viewDidLoad];
    AgoraEduSDKConfig *defaultConfig = [[AgoraEduSDKConfig alloc] initWithAppId:@"7299681c2f0241299b87edbb6ed63750" eyeCare:[[NSUserDefaults standardUserDefaults] boolForKey:@"EYE_PROTECT_STATUS"]];
    [AgoraEduSDK setConfig:defaultConfig];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)setUI {
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = UIColor.whiteColor;
    UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Classroom_bg"]];
    UIImageView *roomNameTextFieldIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-roomNameTextField"]];
    UIImageView *roomTypeSelectViewIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-type"]];
    UIView *sperrateName = [[UIView alloc]init];
    UIView *sperrateType = [[UIView alloc]init];
    sperrateName.backgroundColor = UIColor.grayColor;
    sperrateType.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.enterButtom];
    [self.view addSubview:backgroundImage];
    [self.view addSubview:roomNameTextFieldIcon];
    [self.view addSubview:roomTypeSelectViewIcon];
    [self.view addSubview:sperrateName];
    [self.view addSubview:sperrateType];
    [self.view addSubview:self.roomNameTextField];
    [self.view addSubview:self.roomTypeSelectView];
    [self.enterButtom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(UIScreen.mainScreen.bounds.size.width - 80, 40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-120);
        make.centerX.equalTo(self.view);
    }];
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width * 0.68));
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    [roomNameTextFieldIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(48);
        make.top.equalTo(backgroundImage.mas_bottom);
    }];
    [sperrateName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(UIScreen.mainScreen.bounds.size.width - 96, 0.5));
        make.centerX.equalTo(self.view);
        make.top.equalTo(roomNameTextFieldIcon.mas_bottom).offset(5);
    }];
    [roomTypeSelectViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(48);
        make.top.equalTo(roomNameTextFieldIcon.mas_bottom).offset(72);
    }];
    [sperrateType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(UIScreen.mainScreen.bounds.size.width - 96, 0.5));
        make.centerX.equalTo(self.view);
        make.top.equalTo(roomTypeSelectViewIcon.mas_bottom).offset(5);
    }];
    [self.roomNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 28));
        make.top.equalTo(roomNameTextFieldIcon.mas_top);
        make.left.equalTo(roomNameTextFieldIcon.mas_right).offset(5);
    }];
    [self.roomTypeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280, 28));
        make.top.equalTo(roomTypeSelectViewIcon.mas_top);
        make.left.equalTo(roomTypeSelectViewIcon.mas_right).offset(5);
    }];
}
//MARK:-action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [self.roomTypeSelectView close];
}

- (void)enterRoom {
    [self launchClassroom:@"yuankai" userUuid:@"yk2" roomName:self.roomNameTextField.text roomUuid:self.roomNameTextField.text roomType:self.classType token:@"0067299681c2f0241299b87edbb6ed63750IAD7LSXclBJ3hKfCAfxfZSx3dzfECphNnyjqExqGRs3HRyFpv+oAAAAAEABbnRTnXLOHYAEA6ANcs4dg"];
}

//MARK:-lazy
- (UIButton *)enterButtom {
    if (!_enterButtom) {
        _enterButtom = [[UIButton alloc]init];
        _enterButtom.layer.cornerRadius = 6;
        _enterButtom.layer.masksToBounds = YES;
        [_enterButtom setTitle:@"进入教室" forState:UIControlStateNormal];
        _enterButtom.backgroundColor = UIColor.blackColor;
        [_enterButtom addTarget:self action:@selector(enterRoom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButtom;
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

- (UITextField *)roomNameTextField {
    if (!_roomNameTextField) {
        _roomNameTextField = [[UITextField alloc]init];
        _roomNameTextField.placeholder = @"请输入房间号";
        _roomNameTextField.backgroundColor = UIColor.whiteColor;
        _roomNameTextField.font = [UIFont systemFontOfSize:16];
        _roomNameTextField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _roomNameTextField;
}

- (HWDownSelectedView *)roomTypeSelectView {
    if (!_roomTypeSelectView) {
        _roomTypeSelectView = [HWDownSelectedView new];
        _roomTypeSelectView.placeholder = @"请选择课堂类型";
        _roomTypeSelectView.listArray = @[@"一对一",@"小班课",@"大班课"];
        _roomTypeSelectView.backgroundColor = UIColor.whiteColor;
        _roomTypeSelectView.font = [UIFont systemFontOfSize:16];
    }
    return _roomTypeSelectView;
}

//MARK:-net
- (void)launchClassroom:(NSString *)userName userUuid:(NSString *)userUuid roomName:(NSString *)roomName roomUuid:(NSString *)roomUuid roomType:(AgoraEduRoomType)roomType token:(NSString *)token {

    AgoraEduLaunchConfig *config = [[AgoraEduLaunchConfig alloc] initWithUserName:userName userUuid:userUuid roleType:AgoraEduRoleTypeStudent roomName:roomName roomUuid:roomUuid roomType:roomType token:token];
    [AgoraEduSDK launch:config delegate:self];
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

- (void)downSelectedView:(HWDownSelectedView *)selectedView didSelectedAtIndex:(NSIndexPath *)indexPath {
    NSLog(@"!!!");
}
@end
