//
//  TPImageTitleView.h
//  ThePaperBase
//
//  Created by liubo on 2021/5/19.
//  Copyright © 2021 scar1900. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TPImageTitleView : UIView
extern float rectScale ();

///点击响应
@property (nonatomic, copy) void (^clickBlock)(void);
/// 展示标题
/// @param title 标题
- (void)showTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
