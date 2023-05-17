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
        self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        self.layer.cornerRadius = 2;
        self.layer.shadowColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,2);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 6;
    }
    return self;
}

@end
