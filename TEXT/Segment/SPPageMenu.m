//
//  SPPageMenu.m
//  SPPageMenu
//
//  Created by 乐升平 on 17/10/26.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "SPPageMenu.h"
#import "UIColor+TDHelp.h"

#define tagBaseValue 100
#define scrollViewContentOffset @"contentOffset"
//
#define maxTextScale 0.3

@interface SPPageMenu()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIImageView *tracker;
@property (nonatomic, assign) CGFloat trackerHeight;
@property (nonatomic, weak) UIScrollView *itemScrollView;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIButton *selectedButton;
// 起始偏移量,为了判断滑动方向
@property (nonatomic, assign) CGFloat beginOffsetX;

@property (nonatomic, strong) PageViewConfiguration *configuration;

@end

@implementation SPPageMenu


#pragma mark - public

- (void)setItems:(NSArray *)items selectedItemIndex:(NSUInteger)selectedItemIndex {
    if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
        items = [[items reverseObjectEnumerator] allObjects];
        selectedItemIndex = items.count - 1 - selectedItemIndex;
    }
    _items = items.copy;
    _selectedItemIndex = selectedItemIndex;
    
    
    for (int i = 0; i < items.count; i++) {
        id object = items[i];
        
        NSAssert([object isKindOfClass:[NSString class]] || [object isKindOfClass:[UIImage class]], @"items中的元素只能是NSString或UIImage类型");
        [self addButton:i object:object animated:NO];
    }

    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    if (self.buttons.count) {
        // 默认选中selectedItemIndex对应的按钮
        UIButton *selectedButton = [self.buttons objectAtIndex:selectedItemIndex];
        [self buttonInPageMenuClicked:selectedButton];
    
        [self.itemScrollView insertSubview:self.tracker atIndex:0];
        [self resetSetupTrackerFrameWithSelectedButton:selectedButton];
    }
}

- (NSString *)titleForItemAtIndex:(NSUInteger)itemIndex {
    if (itemIndex < self.buttons.count) {
        UIButton *button = [self.buttons objectAtIndex:itemIndex];
        return button.currentTitle;
    }
    return nil;
}

- (UIImage *)imageForItemAtIndex:(NSUInteger)itemIndex {
    if (itemIndex < self.buttons.count) {
        UIButton *button = [self.buttons objectAtIndex:itemIndex];
        return button.currentImage;
    }
    return nil;
}

#pragma mark  - private

- (void)addButton:(NSInteger)index object:(id)object animated:(BOOL)animated {
    
    // 如果是插入，需要改变已有button的tag值
    for (UIButton *button in self.buttons) {
        if (button.tag-tagBaseValue >= index) {
            button.tag = button.tag + 1;
        }
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:_unSelectedItemTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = _itemTitleFont;
    [button addTarget:self action:@selector(buttonInPageMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tagBaseValue + index;
    if ([object isKindOfClass:[NSString class]]) {
        [button setTitle:object forState:UIControlStateNormal];
    } else {
        [button setImage:object forState:UIControlStateNormal];
    }
    [self.itemScrollView insertSubview:button atIndex:index];
    [self.buttons insertObject:button atIndex:index];
}

- (instancetype)initWithFrame:(CGRect)frame
                       config:(nonnull PageViewConfiguration *)config {
    if (self = [super initWithFrame:frame]) {
        self.configuration = config;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    _itemTitleFont = [UIFont systemFontOfSize:self.configuration.font];
    _selectedItemTitleColor = self.configuration.selectColor;
    _unSelectedItemTitleColor = self.configuration.normalColor;
    _trackerHeight = 3;
    _contentInset = UIEdgeInsetsZero;
    _selectedItemIndex = 0;
    UIScrollView *itemScrollView = [[UIScrollView alloc] init];
    itemScrollView.showsVerticalScrollIndicator = NO;
    itemScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:itemScrollView];
    _itemScrollView = itemScrollView;
    [self layoutIfNeeded];
}

// 按钮点击方法
- (void)buttonInPageMenuClicked:(UIButton *)sender {
   
    
    CGFloat fromIndex = self.selectedButton ? self.selectedButton.tag-tagBaseValue : sender.tag - tagBaseValue;
    CGFloat toIndex = sender.tag - tagBaseValue;
    // 更新下item对应的下标,必须在代理之前，否则外界在代理方法中拿到的不是最新的,必须用下划线，用self.会造成死循环
    _selectedItemIndex = toIndex;
    [self delegatePerformMethodWithFromIndex:fromIndex toIndex:toIndex];

    if (fromIndex != toIndex) { // 如果相等，说明是第一次进来，或者2次点了同一个，此时不需要动画
        [self moveTrackerWithSelectedButton:sender];
    }
    [self handleSelecedSender:sender];

}

- (void)handleSelecedSender:(UIButton *)sender
{
    [self.selectedButton setTitleColor:_unSelectedItemTitleColor forState:UIControlStateNormal];
    [sender setTitleColor:_selectedItemTitleColor forState:UIControlStateNormal];
    self.selectedButton = sender;
    [self moveItemScrollViewWithSelectedButton:sender];
}

// 点击button让itemScrollView发生偏移
- (void)moveItemScrollViewWithSelectedButton:(UIButton *)selectedButton {
    if (CGRectEqualToRect(self.itemScrollView.frame, CGRectZero)) {
        return;
    }
    CGPoint centerInPageMenu = selectedButton.center;
    // CGRectGetMidX(self.backgroundView.frame)指的是屏幕水平中心位置，它的值是固定不变的
    CGFloat offSetX = centerInPageMenu.x - CGRectGetMidX(self.itemScrollView.frame);
    
    // itemScrollView的容量宽与自身宽之差(难点)
    CGFloat maxOffsetX = self.itemScrollView.contentSize.width - self.itemScrollView.frame.size.width;
    // 如果选中的button中心x值小于或者等于itemScrollView的中心x值，或者itemScrollView的容量宽度小于itemScrollView本身，此时点击button时不发生任何偏移，置offSetX为0
    if (offSetX <= 0 || maxOffsetX <= 0) {
        offSetX = 0;
    }
    // 如果offSetX大于maxOffsetX,说明itemScrollView已经滑到尽头，此时button也发生任何偏移了
    else if (offSetX > maxOffsetX){
        offSetX = maxOffsetX;
    }

    [self.itemScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
}

// 移动跟踪器
- (void)moveTrackerWithSelectedButton:(UIButton *)selectedButton {
    
    [UIView animateWithDuration:0.25 animations:^{
        [self resetSetupTrackerFrameWithSelectedButton:selectedButton];
    }];
}

// 执行代理方法
- (void)delegatePerformMethodWithFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageMenu:itemSelectedFromIndex:toIndex:)]) {
        [self.delegate pageMenu:self itemSelectedFromIndex:fromIndex toIndex:toIndex];
    } else if (self.delegate && [self.delegate respondsToSelector:@selector(pageMenu:itemSelectedAtIndex:)]) {
        [self.delegate pageMenu:self itemSelectedAtIndex:toIndex];
    }
}

- (void)beginMoveTrackerFollowScrollView:(UIScrollView *)scrollView {

    // 这个if条件的意思就是没有滑动的意思
    if (!scrollView.dragging && !scrollView.decelerating) {return;}

    // 当滑到边界时，继续通过scrollView的bouces效果滑动时，直接return
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.bounds.size.width) {
        return;
    }
    
    static int i = 0;
    if (i == 0) {
         // 记录起始偏移量，注意千万不能每次都记录，只需要第一次纪录即可。
        // 初始值不能等于scrollView.contentOffset.x,因为第一次进入此方法时，scrollView.contentOffset.x已经有偏移并非刚开始的偏移
        _beginOffsetX = scrollView.bounds.size.width * self.selectedItemIndex;
        i = 1;
    }
    // 当前偏移量
    CGFloat currentOffSetX = scrollView.contentOffset.x;
    // 偏移进度
    CGFloat offsetProgress = currentOffSetX / scrollView.bounds.size.width;
    CGFloat progress = offsetProgress - floor(offsetProgress);

    NSInteger fromIndex;
    NSInteger toIndex;
    
    // 以下注释的“拖拽”一词很准确，不可说成滑动，例如:当手指向右拖拽，还未拖到一半时就松开手，接下来scrollView则会往回滑动，这个往回，就是向左滑动，这也是_beginOffsetX不可时刻纪录的原因，如果时刻纪录，那么往回(向左)滑动时会被视为“向左拖拽”,然而，这个往回却是由“向右拖拽”而导致的
    if (currentOffSetX - _beginOffsetX > 0) { // 向左拖拽了
        // 求商,获取上一个item的下标
        fromIndex = currentOffSetX / scrollView.bounds.size.width;
        // 当前item的下标等于上一个item的下标加1
        toIndex = fromIndex + 1;
        if (toIndex >= self.buttons.count) {
            toIndex = fromIndex;
        }
    } else if (currentOffSetX - _beginOffsetX < 0) {  // 向右拖拽了
        toIndex = currentOffSetX / scrollView.bounds.size.width;
        fromIndex = toIndex + 1;
        progress = 1.0 - progress;

    } else {
        progress = 1.0;
        fromIndex = self.selectedItemIndex;
        toIndex = fromIndex;
    }

    if (currentOffSetX == scrollView.bounds.size.width * fromIndex) {// 滚动停止了
        progress = 1.0;
        toIndex = fromIndex;
    }

    // 如果滚动停止，直接通过点击按钮选中toIndex对应的item
    if (currentOffSetX == scrollView.bounds.size.width*toIndex) { // 这里toIndex==fromIndex
        i = 0;
        // 这一次赋值起到2个作用，一是点击toIndex对应的按钮，走一遍代理方法,二是弥补跟踪器的结束跟踪，因为本方法是在scrollViewDidScroll中调用，可能离滚动结束还有一丁点的距离，本方法就不调了,最终导致外界还要在scrollView滚动结束的方法里self.selectedItemIndex进行赋值,直接在这里赋值可以让外界不用做此操作
        if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
            toIndex = self.buttons.count - 1 - toIndex;
        }
        self.selectedItemIndex = toIndex;
        // 要return，点击了按钮，跟踪器自然会跟着被点击的按钮走
        return;
    }
//     没有关闭跟踪模式
    if (!self.closeTrackerFollowingMode) {
        [self moveTrackerWithProgress:progress fromIndex:fromIndex toIndex:toIndex currentOffsetX:currentOffSetX beginOffsetX:_beginOffsetX];
    }
}

- (void)moveTrackerWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex currentOffsetX:(CGFloat)currentOffsetX beginOffsetX:(CGFloat)beginOffsetX {
    // 下面才开始真正滑动跟踪器，上面都是做铺垫
    UIButton *fromButton = self.buttons[fromIndex];
    UIButton *toButton = self.buttons[toIndex];
    
    // 2个按钮之间的距离
    CGFloat xDistance = toButton.center.x - fromButton.center.x;
    // 2个按钮宽度的差值
    CGFloat wDistance = toButton.frame.size.width - fromButton.frame.size.width;
    
    CGRect newFrame = self.tracker.frame;
    CGPoint newCenter = self.tracker.center;
   
    newCenter.x = fromButton.center.x + xDistance * progress;
    newFrame.size.width = fromButton.frame.size.width + wDistance * progress;
    self.tracker.frame = newFrame;
    self.tracker.center = newCenter;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.bridgeScrollView) {
        if ([keyPath isEqualToString:scrollViewContentOffset]) {
            // 当scrolllView滚动时,让跟踪器跟随scrollView滑动
            [self beginMoveTrackerFollowScrollView:self.bridgeScrollView];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - setter

- (void)setBridgeScrollView:(UIScrollView *)bridgeScrollView {
    _bridgeScrollView = bridgeScrollView;
    if (bridgeScrollView) {
        [bridgeScrollView addObserver:self forKeyPath:scrollViewContentOffset options:NSKeyValueObservingOptionNew context:nil];
    } else {
        NSLog(@"你传了一个空的scrollView");
    }
}

- (void)setItemPadding:(CGFloat)itemPadding {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    // 修正scrollView偏移
    [self moveItemScrollViewWithSelectedButton:self.selectedButton];
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
    _itemTitleFont = itemTitleFont;
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = itemTitleFont;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
    // 修正scrollView偏移
    [self moveItemScrollViewWithSelectedButton:self.selectedButton];
}

- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor {
    _selectedItemTitleColor = selectedItemTitleColor;
    [self.selectedButton setTitleColor:selectedItemTitleColor forState:UIControlStateNormal];
}

- (void)setUnSelectedItemTitleColor:(UIColor *)unSelectedItemTitleColor {
    _unSelectedItemTitleColor = unSelectedItemTitleColor;
    for (UIButton *button in self.buttons) {
        if (button == _selectedButton) {
            continue;  // 跳过选中的那个button
        }
        [button setTitleColor:unSelectedItemTitleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex {
    _selectedItemIndex = selectedItemIndex;
    if (self.buttons.count) {
        UIButton *button = [self.buttons objectAtIndex:selectedItemIndex];
        [self handleSelecedSender:button];
    }
}

- (void)setDelegate:(id<SPPageMenuDelegate>)delegate {
    if (delegate == _delegate) {return;}
    _delegate = delegate;
    if (self.buttons.count) {
        UIButton *button = [self.buttons objectAtIndex:_selectedItemIndex];
        [self delegatePerformMethodWithFromIndex:button.tag-tagBaseValue toIndex:button.tag-tagBaseValue];
        [self moveItemScrollViewWithSelectedButton:button];
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    // 修正scrollView偏移
    [self moveItemScrollViewWithSelectedButton:self.selectedButton];
}

#pragma mark - getter

- (NSArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
        
    }
    return _buttons;
}

- (UIImageView *)tracker {
    
    if (!_tracker) {
        _tracker = [[UIImageView alloc] init];
        _tracker.layer.cornerRadius = _trackerHeight * 0.5;
        _tracker.layer.masksToBounds = YES;
        _tracker.backgroundColor = self.configuration.selectColor;
    }
    return _tracker;
}

#pragma mark - 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat backgroundViewW = self.bounds.size.width-(_contentInset.left+_contentInset.right);
    CGFloat backgroundViewH = self.bounds.size.height-(_contentInset.top+_contentInset.bottom);

    CGFloat itemScrollViewX = 0;
    CGFloat itemScrollViewY = 0;
    CGFloat itemScrollViewW =  backgroundViewW;
    CGFloat itemScrollViewH = backgroundViewH - _trackerHeight;
    self.itemScrollView.frame = CGRectMake(itemScrollViewX, itemScrollViewY, itemScrollViewW, CGRectGetHeight(self.bounds));
    
    __block CGFloat buttonW = 0.0;
    __block CGFloat lastButtonMaxX = 0.0;
    
    CGFloat contentW = 0.0; // 文字宽
    CGFloat contentW_sum = 0.0; // 所有文字宽度之和
    NSMutableArray *buttonWidths = [NSMutableArray array];
    // 提前计算每个按钮的宽度，目的是为了计算间距
    for (int i= 0 ; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        
        CGFloat textW = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, itemScrollViewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_itemTitleFont} context:nil].size.width + 10;
        CGFloat imageW = button.currentImage.size.width;
        if (button.currentTitle && !button.currentImage) {
            contentW = textW;
            if (contentW < [UIScreen mainScreen].bounds.size.width / 5.0) {
                contentW = [UIScreen mainScreen].bounds.size.width / 5.0;
            }
        } else if(button.currentImage && !button.currentTitle) {
            contentW = imageW;
        }
        if (self.configuration.titleWidth) {
            contentW = self.configuration.titleWidth;
        }
       
        contentW_sum += contentW;
        [buttonWidths addObject:@(contentW)];
    }
    
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
      
        buttonW = [buttonWidths[idx] floatValue];
        if (idx == 0) {
            button.frame = CGRectMake(lastButtonMaxX, 0, buttonW, itemScrollViewH - 3);
        } else {
            button.frame = CGRectMake(lastButtonMaxX, 0, buttonW, itemScrollViewH - 3);

        }
        lastButtonMaxX = CGRectGetMaxX(button.frame);
    }];
    
    [self resetSetupTrackerFrameWithSelectedButton:self.selectedButton];
    
    self.itemScrollView.contentSize = CGSizeMake(lastButtonMaxX, 0);
    
    if (self.translatesAutoresizingMaskIntoConstraints == NO) {
        [self moveItemScrollViewWithSelectedButton:self.selectedButton];
    }
}

- (void)resetSetupTrackerFrameWithSelectedButton:(UIButton *)selectedButton {
    
    CGFloat trackerX;
    CGFloat trackerY;
    CGFloat trackerW;
    CGFloat trackerH;
    
    CGFloat selectedButtonWidth = selectedButton.frame.size.width;
   
    trackerW = selectedButtonWidth;
    trackerH = _trackerHeight;
    trackerX = selectedButton.frame.origin.x;
    trackerY = self.itemScrollView.bounds.size.height - trackerH;
    self.tracker.frame = CGRectMake(trackerX, trackerY, trackerW, trackerH);

    CGPoint trackerCenter = self.tracker.center;
    trackerCenter.x = selectedButton.center.x;
    self.tracker.center = trackerCenter;
}

- (void)dealloc {
    [self.bridgeScrollView removeObserver:self forKeyPath:scrollViewContentOffset];
}

@end





