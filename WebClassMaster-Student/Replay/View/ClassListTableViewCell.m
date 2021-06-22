//
//  ClassListTableViewCell.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/29.
//

#import "ClassListTableViewCell.h"

@implementation ClassListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
}
@end
