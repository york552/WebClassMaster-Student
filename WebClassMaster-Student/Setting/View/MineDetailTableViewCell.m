//
//  MineDetailTableViewCell.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/23.
//

#import "MineDetailTableViewCell.h"
#import <Masonry/Masonry.h>

@interface MineDetailTableViewCell()
@property (nonatomic, strong)UILabel *leftLabel;
@property (nonatomic, strong)UILabel *rightLabel;
@end
@implementation MineDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self setUI];
    }
    return self;
}

#pragma mark -UI
- (void)setUI {
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12);
        make.centerY.equalTo(self);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.centerY.equalTo(self);
    }];
}

#pragma mark -Set
- (void)setLeftText:(NSString *)leftText {
    _leftText = leftText;
    self.leftLabel.text = leftText;
}

- (void)setRightText:(NSString *)rightText {
    _rightText = rightText;
    self.rightLabel.text = rightText;
}

#pragma mark -Lazy
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.font = [UIFont systemFontOfSize:16];
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.font = [UIFont systemFontOfSize:16];
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}
@end
