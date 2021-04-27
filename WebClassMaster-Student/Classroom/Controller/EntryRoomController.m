//
//  EntryRoomController.m
//  网课通教师版
//
//  Created by 约克 on 2021/3/16.
//

#import "EntryRoomController.h"
#import "YKTool.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <AgoraEduSDK/AgoraEduSDK.h>

@interface EntryRoomController ()<AgoraEduClassroomDelegate, AgoraEduReplayDelegate>
@property (nonatomic, strong) UIButton *enterButtom;
@property (nonatomic, strong) MBProgressHUD* toastView;//弹出提示
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
    UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Classroom_bg"]];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.enterButtom];
    [self.view addSubview:backgroundImage];
    [self.enterButtom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(UIScreen.mainScreen.bounds.size.width - 80, 40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-90);
        make.centerX.equalTo(self.view);
    }];
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width * 0.68));
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    [self.enterButtom addTarget:self action:@selector(enterRoom) forControlEvents:UIControlEventTouchUpInside];
}
//MARK:-action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
//MARK:-lazy
- (UIButton *)enterButtom {
    if (!_enterButtom) {
        _enterButtom = [[UIButton alloc]init];
        _enterButtom.layer.cornerRadius = 6;
        _enterButtom.layer.masksToBounds = YES;
        [_enterButtom setTitle:@"进入教室" forState:UIControlStateNormal];
        _enterButtom.backgroundColor = UIColor.blackColor;
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

//MARK:-net

- (void)enterRoom {
    NSLog(@"进入教室");
    [self launchClassroom:@"yuankai" userUuid:@"yk2" roomName:@"qwe1" roomUuid:@"qwe1" roomType:AgoraEduRoomTypeSmall token:@"0067299681c2f0241299b87edbb6ed63750IAD7LSXclBJ3hKfCAfxfZSx3dzfECphNnyjqExqGRs3HRyFpv+oAAAAAEABbnRTnXLOHYAEA6ANcs4dg"];
}

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

#pragma mark AgoraEduClassroomDelegate
- (void)classroom:(AgoraEduClassroom *)classroom didReceivedEvent:(AgoraEduEvent)event {

    NSLog(@"classroom:%@ event:%ld", classroom, (long)event);
}

#pragma mark AgoraEduReplayDelegate
- (void)replay:(AgoraEduReplay *)replay didReceivedEvent:(AgoraEduEvent)event {
    NSLog(@"replay:%@ event:%ld", replay, (long)event);
}
@end
