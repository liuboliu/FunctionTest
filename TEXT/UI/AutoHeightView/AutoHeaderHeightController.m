//
//  AutoHeaderHeightController.m
//  TEXT
//
//  Created by liubo on 2023/5/7.
//  Copyright © 2023 刘博. All rights reserved.
//

#import "AutoHeaderHeightController.h"
#import <Masonry/Masonry.h>
#import "TableHederView.h"

@interface AutoHeaderHeightController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *array;

@end

@implementation AutoHeaderHeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    TableHederView *headerView = [[TableHederView alloc] init];
    [self.view addSubview:headerView];
    self.array = @[@"upsaifaskdjf;askldjf;alksdjf;aklsjfasdlkfja;sdklfja;skdlfj;aksdjf;aksldjf;aklsjdf;aklsdjf;klasjdf;klajdsf;alksdfj",
    @"e二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二额二二二二二二二二二二额二二二二二二二二",
                       @"三三三三是哪三是哪三年三三三三三是哪三三三是哪三三三三三三阿森纳三三三三三安萨是哪是哪是哪三年三三三三三三是哪三男撒三三三三三三",
    @"丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上v丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上"];
    [headerView refreshWithArray:self.array];
    
    NSLog(@"这里的大小这里的frame%@", NSStringFromCGRect(headerView.frame));
    
    UIView *view = [[UIView alloc] init];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(100);
    }];
  //  [self refreshWithArray:self.array v:view];
    view.backgroundColor = [UIColor cyanColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *lastView ;

        for (int i = 0; i < self.array.count; i ++) {
            NSString *title = @"akdsjf;alskdjf;alksjdf;alkjdsf;alkjdf;lakjdfs;lkajsdf;lkajsdf;lkajdsf;lkjasd";
            UILabel *label = [[UILabel alloc] init];
            label.text = title;
            label.textColor = [UIColor redColor];
            label.backgroundColor = [UIColor magentaColor];
            [view addSubview:label];
            if (i == 0) {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10);
                    make.right.mas_equalTo(- 10);
                    make.top.mas_equalTo(10);
                    make.height.mas_equalTo(40);
                }];
            } else {
                
                if (i == self.array.count - 1) {
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(10);
                        make.right.mas_equalTo(-10);
                        make.top.equalTo(lastView.mas_bottom).with.offset(10);
                        make.bottom.mas_equalTo(-10);
                    }];
                } else {
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(10);
                        make.right.mas_equalTo(-10);
                        make.top.equalTo(lastView.mas_bottom).with.offset(10);
                    }];
                }
            }
            lastView = label;
            
        }
        

    });
    // Do any additional setup after loading the view.
}

- (void)refreshWithArray:(NSArray *)array v :(UIView  *)superview
{
    UIView *view ;
    for (int i = 0; i < array.count; i ++) {
        NSString *title = array[i];
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.textColor = [UIColor redColor];
        label.backgroundColor = [UIColor magentaColor];
        [superview addSubview:label];
        if (i == 0) {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(- 10);
                make.top.mas_equalTo(10);
            }];
        } else {
            
            if (i == array.count - 1) {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10);
                    make.right.mas_equalTo(-10);
                    make.top.equalTo(view.mas_bottom).with.offset(10);
                    make.bottom.mas_equalTo(-10);
                }];
            } else {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10);
                    make.right.mas_equalTo(-10);
                    make.top.equalTo(view.mas_bottom).with.offset(10);
                }];
            }
        }
        view = label;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

#pragma mark - lazy load

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (void)dealloc
{
    
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
