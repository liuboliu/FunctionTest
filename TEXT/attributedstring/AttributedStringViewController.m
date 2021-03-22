//
//  AttributedStringViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/19.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "AttributedStringViewController.h"

@interface AttributedStringViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *label2;

@end

@implementation AttributedStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 120)];;
    self.label.numberOfLines = 0;
    
    self.label.userInteractionEnabled = YES;
    [self.view addSubview:self.label];
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"哈哈哈哈哈哈哈3423p4ou123piuppoiu" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]}];

    self.label.attributedText = attributed;
    self.label.backgroundColor = [UIColor cyanColor];
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 100, 420)];
    self.label2.numberOfLines = 0;
    [self.view addSubview:self.label2];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.defaultTabInterval = 200;
    style.paragraphSpacingBefore = 40;
    NSAttributedString *attributedst = [[NSAttributedString alloc] initWithString:@"\n哈哈哈哈哈哈哈3423p4ou123piuppoiu" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor],NSParagraphStyleAttributeName:style,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [attributed appendAttributedString:attributedst];
    [attributed addAttributes:@{NSLinkAttributeName : [NSURL URLWithString: @"https://www.baidu.com"]} range:NSMakeRange(0, 10)];
    self.label2.backgroundColor = [UIColor greenColor];
    self.label2.attributedText = attributed;
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
