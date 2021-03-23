//
//  GYRollingNoticeView.m
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "VVNoticeViewCell.h"
#import "VVRollingNoticeView.h"
#import "NSTimer+TDTimer.h"
#import "Header.h"

@interface VVRollingNoticeView ()

@property (nonatomic, strong) NSMutableDictionary *cellClsDict; //注册 cell 的字典，key为cell的类名，value 为identifier
@property (nonatomic, strong) NSMutableArray *reuseCells; //重用cell的实例对象数组
@property (nonatomic, strong) NSTimer *timer; //计时器
@property (nonatomic, strong) VVNoticeViewCell *currentCell; //当前展示的cell
@property (nonatomic, strong) VVNoticeViewCell *willShowCell; //即将展示的cell
@property (nonatomic, assign) BOOL isAnimating; //动画

@end

@implementation VVRollingNoticeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNoticeViews];
    }
    return self;
}

- (void)setupNoticeViews
{
    self.clipsToBounds = YES;
    _stayInterval = 2;
    _animationDuration = 0.66;
    [self addGestureRecognizer:[self createTapGesture]];
}

- (void)registerClass:(nonnull Class)cellClass forCellReuseIdentifier:(NSString *)identifier
{
    [self.cellClsDict setObject:NSStringFromClass(cellClass) forKey:identifier];
}

- (__kindof VVNoticeViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    for (VVNoticeViewCell *cell in self.reuseCells)
    {
        if ([cell.reuseIdentifier isEqualToString:identifier]) {
            return cell;
        }
    }
    
    Class cellCls = NSClassFromString(self.cellClsDict[identifier]);
    VVNoticeViewCell *cell = [[cellCls alloc] initWithReuseIdentifier:identifier];
    return cell;
}

#pragma mark- rolling
- (void)layoutCurrentCellAndWillShowCell
{
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    int willShowIndex = _currentIndex + 1;
    if (willShowIndex > count - 1) {
        willShowIndex = 0;
    }
    
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    if (!_currentCell) {
        // 第一次没有currentcell
        // currentcell is null at first time
        _currentCell = [self.dataSource rollingNoticeView:self cellAtIndex:_currentIndex];
        _currentCell.frame = CGRectMake(0, 0, w, h);
        [self addSubview:_currentCell];
        if (self.style == RollingStyleDefault) {
            ///默认轮播滚动样式，首次展示不需要加载下一个
            return;
        }
    }
    CGFloat willY = h + self.spaceOfItem;
    if (self.style == RollingStyleFade) {
        //淡入淡出的样式
        willY = 4;
    }
    _willShowCell = [self.dataSource rollingNoticeView:self cellAtIndex:willShowIndex];
    _willShowCell.frame = CGRectMake(0, willY, w, h);
    if (self.style == RollingStyleFade) {
        ///首次展示currentCell的时候，will 需要隐藏
        _willShowCell.alpha = 0;
    }
    if (![self.subviews containsObject:_willShowCell]) {
        [self addSubview:_willShowCell];
    }

    [self.reuseCells removeObject:_currentCell];
    [self.reuseCells removeObject:_willShowCell];
}

- (void)reloadDataAndStartRoll
{
    [self stopTimer];
    
    [self layoutCurrentCellAndWillShowCell];
    NSInteger count = [self.dataSource numberOfRowsForRollingNoticeView:self];
    if (count && count < 2) {
        return;
    }
    self.timer = [NSTimer td_timerWithTimeInterval:_stayInterval + _animationDuration target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _isAnimating = NO;
    _currentIndex = 0;
    [_currentCell removeFromSuperview];
    [_willShowCell removeFromSuperview];
    _currentCell = nil;
    _willShowCell = nil;
    [self.reuseCells removeAllObjects];
}

- (void)pause
{
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)proceed
{
    if (_timer) {
        [_timer setFireDate:[NSDate date]];
    }
}

- (void)timerHandle
{
    if (self.isAnimating) {
        return;
    }
    if (self.style == RollingStyleDefault) {
        [self defaultTimeHandler];
    } else if (self.style == RollingStyleFade) {
        [self fadeTimeHandler];
    }
}
    
- (void)defaultTimeHandler
{
    [self layoutCurrentCellAndWillShowCell];
    _currentIndex++;
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    self.isAnimating = YES;
    
    @weakify(self);
    [UIView animateWithDuration:_animationDuration animations:^{
        @strongify(self);
        self.currentCell.frame = CGRectMake(0, - h - self.spaceOfItem, w, h);
        self.willShowCell.frame = CGRectMake(0, 0, w, h);
    }
                     completion:^(BOOL finished) {
        @strongify(self);
        // fixed bug: reload data when animate running
        if (self.currentCell && self.willShowCell) {
            [self.reuseCells addObject:self.currentCell];
            [self.currentCell removeFromSuperview];
            self.currentCell = self.willShowCell;
        }
        self.isAnimating = NO;
    }];
}
    
- (void)fadeTimeHandler
{
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    self.isAnimating = YES;
    [self.reuseCells removeObject:_currentCell];
    [self.reuseCells removeObject:_willShowCell];
    @weakify(self);
    [UIView animateWithDuration:self.animationDuration animations:^{
        @strongify(self);
        self.currentCell.alpha = 0;
    }
                     completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:self.animationDuration - 0.1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.currentCell.frame = CGRectMake(0, - self.fadeTranslationY, w, h);
    } completion:^(BOOL finished) {
        [self showNext];
        self.currentCell.frame = CGRectMake(0, 0, w, h);
    }];
}

- (void)showNext
{
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.willShowCell.alpha = 1;
    } completion:^(BOOL finished) {
    }] ;
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    [UIView animateWithDuration:self.animationDuration - 0.1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.willShowCell.frame = CGRectMake(0, 0, w, h);
    } completion:^(BOOL finished) {
        self->_currentIndex++;
        int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
        if (self->_currentIndex > count - 1) {
            self->_currentIndex = 0;
        }
        if (self.currentCell && self.willShowCell) {
            [self.reuseCells addObject:self.currentCell];
        }
        self.isAnimating = NO;
        int willShowIndex = self->_currentIndex + 1;
        if (willShowIndex > count - 1) {
            willShowIndex = 0;
        }
        self->_currentCell = self->_willShowCell;
        self->_willShowCell = [self.dataSource rollingNoticeView:self cellAtIndex:willShowIndex];
        self->_willShowCell.frame = CGRectMake(0, self.fadeTranslationY, w, h);
        self->_willShowCell.alpha = 0;
        [self addSubview:self.willShowCell];
    }];
}

#pragma mark - gesture

- (void)handleCellTapAction
{
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    if ([self.delegate respondsToSelector:@selector(didClickRollingNoticeView:forIndex:)]) {
        [self.delegate didClickRollingNoticeView:self forIndex:_currentIndex];
    }
}

- (UITapGestureRecognizer *)createTapGesture
{
    return [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCellTapAction)];
}

#pragma mark- lazy
- (NSMutableDictionary *)cellClsDict
{
    if (!_cellClsDict) {
        _cellClsDict = [[NSMutableDictionary alloc]init];
    }
    return _cellClsDict;
}

- (NSMutableArray *)reuseCells
{
    if (!_reuseCells) {
        _reuseCells = [[NSMutableArray alloc]init];
    }
    return _reuseCells;
}

@end

