//
//  TestView.h
//  TEXT
//
//  Created by Apple on 2021/1/24.
//  Copyright © 2021 刘博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardCourseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestView : UILabel

@property (copy, nonatomic) void (^block) (void);
@property (copy, nonatomic) NSString *string;

@end

NS_ASSUME_NONNULL_END
