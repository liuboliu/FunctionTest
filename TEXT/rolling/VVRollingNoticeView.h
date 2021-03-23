//
//  GYRollingNoticeView.h
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVNoticeViewCell.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RollingStyle) {
    RollingStyleDefault = 0, ///默认样式，滚动轮播
    RollingStyleFade = 1, /// 渐变轮播
};

@class VVRollingNoticeView;

@protocol VVRollingNoticeViewDataSource <NSObject>

@required
// 轮播视图数量
- (NSInteger)numberOfRowsForRollingNoticeView:(VVRollingNoticeView *)rollingView;
//返回当前展示的轮播视图
- (VVNoticeViewCell *)rollingNoticeView:(VVRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index;

@end

@protocol VVRollingNoticeViewDelegate <NSObject>
@optional
//点击方法代理
- (void)didClickRollingNoticeView:(VVRollingNoticeView *)rollingView forIndex:(NSUInteger)index;

@end

@interface VVRollingNoticeView : UIView

@property (nonatomic, weak) id<VVRollingNoticeViewDataSource> dataSource;
@property (nonatomic, weak) id<VVRollingNoticeViewDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval stayInterval; // 停留 默认2秒
@property (nonatomic, assign) NSTimeInterval animationDuration ; //动画时间，默认0.66秒
@property (nonatomic, assign, readonly) int currentIndex;
@property (nonatomic, assign) CGFloat spaceOfItem;//Item之间的距离，默认为零
@property (nonatomic, assign) CGFloat fadeTranslationY; ///  淡入淡出样式下的位移移动量

///录播风格
@property (nonatomic, assign) RollingStyle style;

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (__kindof VVNoticeViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (void)reloadDataAndStartRoll;
- (void)stopTimer; // 如果想要释放，请在合适的地方停止timer。 If you want to release, please stop the timer in the right place,for example '-viewDidDismiss'
//暂停
- (void)pause;

//继续
- (void)proceed;

@end

NS_ASSUME_NONNULL_END
