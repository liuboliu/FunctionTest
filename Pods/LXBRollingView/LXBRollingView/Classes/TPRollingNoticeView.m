//
//  RollingCell.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/18.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "TPNoticeViewCell.h"
#import "TPRollingNoticeView.h"

@interface TPRollingNoticeView ()

@property (nonatomic, strong) NSMutableDictionary *cellClsDict; //注册 cell 的字典，key为cell的类名，value 为identifier
@property (nonatomic, strong) NSMutableArray *reuseCells; //重用cell的实例对象数组
@property (nonatomic, strong) NSTimer *timer; //计时器
@property (nonatomic, strong) TPNoticeViewCell *currentCell; //当前展示的cell
@property (nonatomic, strong) TPNoticeViewCell *willShowCell; //即将展示的cell
@property (nonatomic, assign) BOOL isAnimating; //动画
@property (nonatomic, assign) BOOL isRefresing ; ///在刷新, 多次刷新的时候，防止上次未执行完的动画对新的一轮刷新造成干扰

@end

@implementation TPRollingNoticeView


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
    _fadeTranslationY = 6;
    [self addGestureRecognizer:[self createTapGesture]];
}

- (void)registerClass:(nonnull Class)cellClass forCellReuseIdentifier:(NSString *)identifier
{
    [self.cellClsDict setObject:NSStringFromClass(cellClass) forKey:identifier];
}

- (__kindof TPNoticeViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    for (TPNoticeViewCell *cell in self.reuseCells)
    {
        if ([cell.reuseIdentifier isEqualToString:identifier]) {
            cell.userInteractionEnabled = NO;
            return cell;
        }
    }
    
    Class cellCls = NSClassFromString(self.cellClsDict[identifier]);
    TPNoticeViewCell *cell = [[cellCls alloc] initWithReuseIdentifier:identifier];
    cell.userInteractionEnabled = NO;
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
        if (![self.subviews containsObject:self.currentCell]) {
            [self addSubview:_currentCell];
        }
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

    self.isRefresing = YES;
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
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer timerWithTimeInterval:self.stayInterval + self.animationDuration repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf timerHandle];
    }];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
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
    
    [UIView animateWithDuration:_animationDuration animations:^{
        self.currentCell.frame = CGRectMake(0, - h - self.spaceOfItem, w, h);
        self.willShowCell.frame = CGRectMake(0, 0, w, h);
    } completion:^(BOOL finished) {
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
    self.isRefresing = NO;
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    self.isAnimating = YES;
    [self.reuseCells removeObject:_currentCell];
    [self.reuseCells removeObject:_willShowCell];
    ///动画隐藏当前的cell
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (self.isRefresing) {
            self.currentCell.alpha = 1;
        } else {
            self.currentCell.alpha = 0;
        }
    } completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:self.animationDuration - 0.1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        if (self.isRefresing) {
            self.currentCell.frame = CGRectMake(0, 0, w, h);
        } else {
            self.currentCell.frame = CGRectMake(0, - self.fadeTranslationY, w, h);
        }
    } completion:^(BOOL finished) {
    }];
    ///动画展示下一个cell ,
    /*
     这里减0.07是需要在上面文案的动画还没有结束的时候，
     下面文案的动画就要开始了
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.animationDuration - 0.07) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showNext];
    });
}

- (void)showNext
{
    [UIView animateWithDuration:self.animationDuration animations:^{
        if (self.isRefresing) {
            self.willShowCell.alpha = 0;
        } else {
            self.willShowCell.alpha = 1;
        }
    } completion:^(BOOL finished) {
    }] ;
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    [UIView animateWithDuration:self.animationDuration - 0.1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        if (self.isRefresing) {
            self.willShowCell.frame = CGRectMake(0, self.fadeTranslationY, w, h);
        } else {
            self.willShowCell.frame = CGRectMake(0, 0, w, h);
        }
    } completion:^(BOOL finished) {
        if (self.isRefresing) {
            return;
        }
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

- (void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer  = nil;
    }
}

@end

