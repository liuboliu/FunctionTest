//
//  TableHederView.m
//  TEXT
//
//  Created by liubo on 2023/5/7.
//  Copyright © 2023 刘博. All rights reserved.
//

#import "TableHederView.h"
#import <Masonry/Masonry.h>

@interface TableHederView ()

@end

@implementation TableHederView

- (void)refreshWithArray:(NSArray *)array
{
    UIView *view ;
    for (int i = 0; i < array.count; i ++) {
        NSString *title = array[i];
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        [self addSubview:label];
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

@end
