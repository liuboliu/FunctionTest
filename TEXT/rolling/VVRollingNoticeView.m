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

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupNoticeViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNoticeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier
{
    [self.cellClsDict setObject:nib forKey:identifier];
}

- (__kindof VVNoticeViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    for (VVNoticeViewCell *cell in self.reuseCells)
    {
        if ([cell.reuseIdentifier isEqualToString:identifier]) {
            return cell;
        }
    }
    
    id cellClass = self.cellClsDict[identifier];
    if ([cellClass isKindOfClass:[UINib class]]) {
        UINib *nib = (UINib *)cellClass;
        
        NSArray *arr = [nib instantiateWithOwner:nil options:nil];
        VVNoticeViewCell *cell = [arr firstObject];
        [cell setValue:identifier forKeyPath:@"reuseIdentifier"];
        return cell;
    } else {
        Class cellCls = NSClassFromString(self.cellClsDict[identifier]);
        VVNoticeViewCell *cell = [[cellCls alloc] initWithReuseIdentifier:identifier];
        return cell;
    }
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
        return;
    }
    _willShowCell = [self.dataSource rollingNoticeView:self cellAtIndex:willShowIndex];
    _willShowCell.frame = CGRectMake(0, h + self.spaceOfItem, w, h);
    _willShowCell.alpha = 0;
    [self addSubview:_willShowCell];
    if (GYRollingDebugLog) {
        NSLog(@"_currentCell  %p", _currentCell);
        NSLog(@"_willShowCell %p", _willShowCell);
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
    [self layoutCurrentCellAndWillShowCell];
    _currentIndex++;
    int count = (int)[self.dataSource numberOfRowsForRollingNoticeView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    self.isAnimating = YES;
    [UIView animateWithDuration:.05 animations:^{
        self.currentCell.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
    
    @weakify(self);
    [UIView animateWithDuration:_animationDuration animations:^{
        @strongify(self);
        self.willShowCell.alpha = 1;
        self.currentCell.frame = CGRectMake(0, - h - self.spaceOfItem, w, h);
        self.willShowCell.frame = CGRectMake(0, 0, w, h);
    }
                     completion:^(BOOL finished) {
                         @strongify(self);
                         // fixed bug: reload data when animate running
                         if (self.currentCell && self.willShowCell) {
                             [self.reuseCells addObject:self.currentCell];
                             [self.currentCell removeFromSuperview];
                             self.currentCell.alpha = 1;
                             self.currentCell = self.willShowCell;
                         }
                         self.isAnimating = NO;
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

