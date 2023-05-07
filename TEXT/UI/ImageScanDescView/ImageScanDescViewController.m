//
//  ImageScanDescViewController.m
//  TEXT
//
//  Created by liubo on 2023/5/7.
//  Copyright © 2023 刘博. All rights reserved.
//

#import "ImageScanDescViewController.h"
#import "DescView.h"

@interface ImageScanDescViewController ()

@end

@implementation ImageScanDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DescView *descView = [[DescView alloc] initWithDescString:@"这是一个非常漂亮的图片这里是一个非常漂亮的图片这里是个非常漂亮的图片这里一个非常漂亮的图片这里一个非常漂亮的推案这里这是一个非常漂亮的图拍呢这里一个非常漂亮的体拼啊,这是一个非常漂亮的图片这里是一个非常漂亮的图片这里是个非常漂亮的图片这里一个非常漂亮的图片这里一个非常漂亮的推案这里这是一个非常漂亮的图拍呢这里一个非常漂亮的体拼啊" tagString:@"1/1" andAuthor:@"作者：人民日报"];
        [self.view addSubview:descView];
    });
  
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
