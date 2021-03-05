//
//  PresentedViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/5.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "PresentedViewController.h"
#import "TDViewControllerPresentAndDismiss.h"

@interface PresentedViewController ()

@property (nonatomic, strong) id vv;
@property (nonatomic, strong) UIButton  *contet;

@end

@implementation PresentedViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.vv = [[TDViewControllerPresentAndDismiss alloc] initWithViewController:self duration:0.5 present:^(TDViewControllerPresentAndDismissCompletionBlock completion) {
            [UIView animateWithDuration:0.4 animations:^{
                self.contet.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 400, CGRectGetWidth(self.view.bounds), 400);
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
            
        } dismiss:^(TDViewControllerPresentAndDismissCompletionBlock completion) {
            [UIView animateWithDuration:0.4 animations:^{
                self.view.backgroundColor = [UIColor clearColor];
                self.contet.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), 400);
             }
             completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.contet];
    UIButton *bitotn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bitotn];
    bitotn.frame = CGRectMake(100, 100, 100, 100);
    [bitotn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    bitotn.backgroundColor = [UIColor magentaColor];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)click
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)contet
{
    if (!_contet) {
        _contet = [UIButton buttonWithType:UIButtonTypeCustom];
        _contet.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), 400);
        _contet.backgroundColor = [UIColor greenColor];
        [_contet addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
   return _contet;
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
