//
//  WeakStrongController.m
//  TEXT
//
//  Created by Apple on 2021/2/8.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "WeakStrongController.h"
#import "TestView.h"

typedef void(^TTestBlock)(int result);


@interface WeakStrongController ()

@property (copy, nonatomic)  TTestBlock  aBlock ;

@property (strong, nonatomic) TestView *kkview;

@end

@implementation WeakStrongController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testForBlock];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)testForBlock{
    
    TestView *view = [[TestView alloc] init];
   // self.kkview = view;
    view.string =  @"内容内容内容";
    __weak typeof(view) weakView = view;
    view.block = ^{
        __strong typeof (weakView) strongView = weakView;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"这列这里这里这里%@",strongView.string);
            });
    };
    view.block();
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
