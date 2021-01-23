//
//  CardCourseViewController.m
//  TEXT
//
//  Created by Apple on 2021/1/23.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "CardCourseViewController.h"

@interface CardCourseViewController () <UIScrollViewDelegate>


@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CardCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    return;
    if (scrollView.contentOffset.x > scrollView.contentSize.width -(scrollView.bounds.size.width + 40)) {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - (scrollView.bounds.size.width + 40), 0);
    }
}

- (UIColor *)arndomColor

{

CGFloat red = arc4random_uniform(256)/ 255.0;

CGFloat green = arc4random_uniform(256)/ 255.0;

CGFloat blue = arc4random_uniform(256)/ 255.0;

UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

return color;

}


#pragma mark  - lazy load

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, CGRectGetWidth(self.view.frame) - 20, 100)];
        _contentView.backgroundColor = [UIColor redColor];
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 60, 100)];
        _scrollView.backgroundColor = [UIColor greenColor];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * 6, 100);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, - 40);
        for (int i = 0; i < 6; i ++) {
            UIView *view = [[UIView alloc] init];
            view.frame = CGRectMake(i * (self.view.bounds.size.width - 60) , 0, self.view.bounds.size.width - 60, 90);
            view.backgroundColor = [self arndomColor];
            [_scrollView addSubview:view];
        }
        _scrollView.clipsToBounds = NO;
    }
    return _scrollView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
