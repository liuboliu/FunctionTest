//
//  ViewControllerEnumObject.m
//  TEXT
//
//  Created by 刘博 on 2020/12/17.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerEnumObject.h"

@interface ViewControllerEnumObject ()

@end

@implementation ViewControllerEnumObject

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"ff",@"uuu",@"kkkk",@"iiii",@"llll"];
//    NSString *kk;
//    for (NSString *url in array) {
//        if ([url isEqualToString:@"kkkk"]) {
//            kk = url;
//            break;
//        }
//        NSLog(@"哈哈哈哈哈哈哈%@",url);
//    }
//    NSLog(@"更新之后更新之后%@",kk);

    __block NSString *kk = nil;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"kkkk"]) {
            kk = obj;
//            *stop = YES;
            return;
            *stop = YES;
        }
        NSLog(@"哈哈哈哈哈哈哈%@",obj);
    }];
    NSLog(@"更新之后更新之后%@",kk);
    

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
