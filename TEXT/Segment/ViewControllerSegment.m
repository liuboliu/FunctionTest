//
//  ViewControllerSegment.m
//  TEXT
//
//  Created by 刘博 on 2020/12/18.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerSegment.h"
#import "SPPageMenu.h"

@interface ViewControllerSegment ()

@end

@implementation ViewControllerSegment

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    scroll.frame = CGRectMake(0, 160, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    scroll.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 6, 400);
    
    SPPageMenu *menu = [[SPPageMenu alloc] initWithFrame:CGRectMake(0, 120, CGRectGetWidth(self.view.frame), 40) ];
    scroll.pagingEnabled = YES;
    [menu setItems:@[@"fasdf",@"afsfasd",@"kkkki",@"88888",@"777777",@"99999"] selectedItemIndex:0];
    menu.bridgeScrollView = scroll;
    [self.view addSubview:menu];
    self.view.backgroundColor = [UIColor yellowColor];
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
