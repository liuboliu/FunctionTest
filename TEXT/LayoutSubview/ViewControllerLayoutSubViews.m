//
//  ViewControllerLayoutSubViews.m
//  TEXT
//
//  Created by 刘博 on 2020/12/26.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerLayoutSubViews.h"
#import "KKScrollView.h"

@interface ViewControllerLayoutSubViews () <UIScrollViewDelegate>

@end

@implementation ViewControllerLayoutSubViews

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    KKScrollView *scoll = [[KKScrollView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    scoll.contentSize = CGSizeMake(200  * 10, 100);
    scoll.pagingEnabled = YES;
    scoll.backgroundColor = [UIColor greenColor];
    scoll.delegate = self;
    scoll.frame = CGRectMake(100, 100, 300, 200);

    [self.view addSubview:scoll];
    scoll.frame = CGRectMake(100, 100, 300, 100);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    view.backgroundColor = [UIColor blueColor];
    [scoll addSubview:view];
    
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"滚动滚动滚动");
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
