//
//  ViewControllerLayoutSubviews.m
//  TEXT
//
//  Created by Apple on 2020/12/20.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerLayoutSubviews.h"
#import "KK.h"

@interface ViewControllerLayoutSubviews ()

@end

@implementation ViewControllerLayoutSubviews

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KK *scrollview = [[KK alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    scrollview.contentSize = CGSizeMake(100 * 4, 100);
    [self.view addSubview:scrollview];
    self.view.backgroundColor = [UIColor redColor];
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
