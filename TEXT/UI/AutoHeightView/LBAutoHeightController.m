//
//  LBAutoHeightController.m
//  TEXT
//
//  Created by liubo on 2023/4/30.
//  Copyright © 2023 刘博. All rights reserved.
//

#import "LBAutoHeightController.h"
#import <Masonry/Masonry.h>
#import "ContentLabel.h"

@interface LBAutoHeightController ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) ContentLabel *contentTitle;

@property (nonatomic, strong) ContentLabel *descTitle;

@end

@implementation LBAutoHeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(100);
        
    }];
    
    [self.contentView addSubview:self.contentTitle];
    [self.contentView addSubview:self.descTitle];
    
    [self.contentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
    }];
    
    [self.descTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.contentTitle.mas_bottom).with.offset(30);
        make.bottom.mas_equalTo(-10);
    }];
    
    
}

#pragma mark - lazy load

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor cyanColor];
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"哈哈哈哈哈这里是标题这里是标题这里是标题这里是标题这里标题这里是标题这里是标题这里是标题这里是标题这里是标题";
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"爱上；快点减肥；卢卡斯剪短发；了卡加水淀粉；了卡加水淀粉；离开家啊是；对方离开家啊是；了对方空间啊；卢卡斯的飞机；阿莱克斯剪短发；啦开始就地方；卢卡斯剪短发；了卡加水淀粉；离开家啊是短发；离开家啊是短发；离开家啊是的；发了；了卡加水淀粉啦数据短发爱上；快点减肥；卢卡斯剪短发；了卡加水淀粉；了卡加水淀粉；离开家啊是；对方离开家啊是；了对方空间啊；卢卡斯的飞机；阿莱克斯剪短发；啦开始就地方；卢卡斯剪短发；了卡加水淀粉；离开家啊是短发；离开家啊是短发；离开家啊是的；发了；了卡加水淀粉啦数据短发";
    }
    return _contentLabel;;
}

- (ContentLabel *)contentTitle
{
    if (!_contentTitle) {
        _contentTitle = [[ContentLabel alloc] init];
        _contentTitle.text = @"哈哈哈哈哈这里是标题这里是标题这里是标题这里是标题这里标题这里是标题这里是标题这里是标题这里是标题这里是标题";
    }
    return _contentTitle;
}

- (ContentLabel *)descTitle
{
    if (!_descTitle) {
        _descTitle = [[ContentLabel alloc] init];
        _descTitle.text = @"爱上；快点减肥；卢卡斯剪短发；了卡加水淀粉；了卡加水淀粉；离开家啊是；对方离开家啊是；了对方空间啊；卢卡斯的飞机；阿莱克斯剪短发；啦开始就地方；卢卡斯剪短发；了卡加水淀粉；离开家啊是短发；离开家啊是短发；离开家啊是的；发了；了卡加水淀粉啦数据短发爱上；快点减肥；卢卡斯剪短发；了卡加水淀粉；了卡加水淀粉；离开家啊是；对方离开家啊是；了对方空间啊；卢卡斯的飞机；阿莱克斯剪短发；啦开始就地方；卢卡斯剪短发；了卡加水淀粉；离开家啊是短发；离开家啊是短发；离开家啊是的；发了；了卡加水淀粉啦数据短发";
    }
    return _descTitle;
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
