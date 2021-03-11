//
//  KeyValueViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/8.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "KeyValueViewController.h"
#import "Student.h"

typedef NS_ENUM(NSUInteger, Mytype) {
    MytypeO,
    Mytype1,
    Mytype2,
};

@interface KeyValueViewController ()



@end

@implementation KeyValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    Student *student = [[Student alloc] init];
    [student setValue:@"xiaoming" forKey:@"name"];
    [student setValue:nil forKey:@"name"];
    Mytype type = Mytype2;
    
    NSLog(@"哈哈哈哈%ld",(Mytype2 | MytypeO));
    NSLog(@"哈哈哈哈%ld",(Mytype1 | Mytype1));
    NSLog(@"哈哈哈哈%ld",(Mytype2 | Mytype1));
    NSLog(@"哈哈哈哈%ld",(Mytype1 | MytypeO));
    NSLog(@"哈哈哈哈%ld",(Mytype2 | Mytype2));
    NSLog(@"哈哈哈哈%ld",(MytypeO | MytypeO));
    NSLog(@"哈哈哈哈%ld",(Mytype1 | Mytype2));


    if (type == (Mytype1 | Mytype1)) {
        NSLog(@"打印打印");
    }

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
