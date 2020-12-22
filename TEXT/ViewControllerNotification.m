//
//  ViewControllerNotification.m
//  TEXT
//
//  Created by 刘博 on 2020/12/18.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerNotification.h"
#import "VVCell.h"

@interface ViewControllerNotification ()

@property (nonatomic, strong) VVCell *cell;

@property (nonatomic, copy) NSString *test;

@end

@implementation ViewControllerNotification

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    self.test = @"";
    if (self.test) {
        NSLog(@"不为空不为空不为空");
    }
    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"name"]) {
       // NSLog(@"哈哈哈哈哈哈");
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)kkkk
{
   // NSLog(@"通知了通知了统统汉子了通天之类通知了通知了");
}

- (void)dealloc
{
    NSLog(@"页面释放了页面释放了");
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
