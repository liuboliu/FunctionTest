//
//  VVCategoryBannerDecorationView.m
//  VOVA
//
//  Created by 刘博 on 2020/12/14.
//  Copyright © 2020 iOS. All rights reserved.
//

#import "VVCategoryBannerDecorationView.h"

@implementation VVCategoryBannerDecorationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8;
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
