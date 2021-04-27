//
//  ClassViewController.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/23.
//

#import "ClassViewController.h"
#import "ChooseClassViewController.h"
#import "ClassInfoViewController.h"
#import <JXCategoryView/JXCategoryView.h>

@interface ClassViewController ()<JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <UIViewController *> *listViewArray;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"课程";
    [self setUI];
}

#pragma mark -UI
- (void)setUI {
    [self.view addSubview:self.categoryView];
}
#pragma mark -lazy


- (JXCategoryTitleView *)categoryView{
    if(!_categoryView){
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        _categoryView.delegate = self;
        _categoryView.titles = @[@"选课",@"课表"];
        _categoryView.backgroundColor = [UIColor whiteColor];
        _categoryView.titleColor = UIColor.blackColor;
        _categoryView.titleSelectedColor = UIColor.redColor;
        _categoryView.titleFont = [UIFont systemFontOfSize:16];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:16];
        // 标题色是否渐变过渡
        _categoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = UIColor.redColor;
        lineView.indicatorWidth = 35;
        _categoryView.indicators = @[lineView];
//        _categoryView.contentScrollView = self.pagingView.listContainerView.scrollView;
        // 返回上一页侧滑手势（仅在index==0时有效）
        self.navigationController.interactivePopGestureRecognizer.enabled = (_categoryView.selectedIndex == 0);
    }
    
    return _categoryView;
}

@end
