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
    self.view.backgroundColor = [UIColor whiteColor];
    TableHederView *headerView = [[TableHederView alloc] init];
    headerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(100);
    }];
    self.array = @[@"upsaifaskdjf;askldjf;alksdjf;aklsjfasdlkfja;sdklfja;skdlfj;aksdjf;aksldjf;aklsjdf;aklsdjf;klasjdf;klajdsf;alksdfj",
                   @"e二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二额二二二二二二二二二二额二二二二二二二二",
                   @"三三三三是哪三是哪三年三三三三三是哪三三三是哪三三三三三三阿森纳三三三三三安萨是哪是哪是哪三年三三三三三三是哪三男撒三三三三三三",
                   @"丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上v丝丝丝丝丝丝丝丝丝丝上丝丝丝丝丝丝丝丝丝丝上"];
    [headerView refreshWithArray:self.array];
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
