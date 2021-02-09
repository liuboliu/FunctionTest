//
//  __BlockViewController.m
//  TEXT
//
//  Created by Apple on 2021/2/8.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "__BlockViewController.h"

@interface __BlockViewController ()

@end

@implementation __BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block UIView *view = [[UIView alloc] init];
    void (^block)(void) = ^ {
        view = [[UIView alloc] init];
    };
    block();
    // Do any additional setup after loading the view.
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
