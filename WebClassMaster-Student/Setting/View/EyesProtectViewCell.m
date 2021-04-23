//
//  eyesProtectViewCell.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/22.
//

#import "EyesProtectViewCell.h"
#import <Masonry/Masonry.h>

@interface EyesProtectViewCell()
@property (nonatomic, strong) UISwitch *eyeSwitch;
@end

@implementation EyesProtectViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.eyeSwitch];
    [self.eyeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(51, 31));
    }];
}

#pragma mark -lazy
- (UISwitch *)eyeSwitch {
    if (!_eyeSwitch) {
        _eyeSwitch = [[UISwitch alloc]init];
        [_eyeSwitch addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    }
    return _eyeSwitch;
}

#pragma mark -action
- (void)change:(UISwitch *)swi {
    if (swi.isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"EYE_PROTECT_STATUS"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"EYE_PROTECT_STATUS"];
    }
}
@end
