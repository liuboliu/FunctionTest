//
//  JKScrollHelper.m
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import "JKScrollHelper.h"
#import <Aspects/Aspects.h>
#import "NSObject+VVKVOHelper.h"

@interface JKScrollHelperView()

@property (nonatomic,weak) UIScrollView *jk_scrollHelper_Scroll;

@end;

@implementation JKScrollHelperView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.bounds, point)) {
        NSEnumerator *enumerator = [self.subviews reverseObjectEnumerator];

      for (UIView *subView in enumerator) {
          CGPoint tempoint = [subView convertPoint:point fromView:self];
         UIView *hitView = [subView hitTest:tempoint withEvent:event];
          if (subView == hitView) {
              break;
          }
          if (hitView) {
              return hitView;
              break;
          }
      }

        if (self.jk_scrollHelper_Scroll) {
            return self.jk_scrollHelper_Scroll;
        }
    }
    return [super hitTest:point withEvent:event];
}

@end

@implementation JKScrollExtraViewConfig


@end

@interface JKScrollHelper()

@property (nonatomic, assign)CGSize defautHeaderSize;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat contentInsetTop;
@property (nonatomic, assign) CGFloat contentInsetBottom;
@property (nonatomic, assign) CGFloat originHeaderY;
@property (nonatomic, strong) JKScrollExtraViewConfig *extraHeaderViewConfig;

@end

@implementation JKScrollHelper

+ (instancetype)initWithScrollView:(UIScrollView *)scrollView
                  headerViewCofnig:(JKScrollExtraViewConfig *)headerConfig
                   commonSuperView:(__kindof UIView *)commonSuperView
{
    JKScrollHelper *scrollViewHelper = [[self alloc] init];
    if(scrollViewHelper){
        
        headerConfig.frontView.clipsToBounds = YES;
        headerConfig.frontView.jk_scrollHelper_Scroll = scrollView;
        headerConfig.backgroundView.clipsToBounds = YES;
        headerConfig.backgroundView.jk_scrollHelper_Scroll = scrollView;
        scrollViewHelper.extraHeaderViewConfig = headerConfig;
        CGRect frame = headerConfig.frontView.frame;
        scrollViewHelper.scrollView = scrollView;
        CGFloat height = 0;
        
        
        scrollViewHelper.defautHeaderSize = frame.size;
        scrollViewHelper.contentInsetTop = frame.size.height-height;
        scrollViewHelper.contentInsetBottom = 0;
        scrollView.contentInset = UIEdgeInsetsMake(scrollViewHelper.contentInsetTop, 0, scrollViewHelper.contentInsetBottom, 0);
        [scrollView setContentOffset:CGPointMake(0, -scrollViewHelper.contentInsetTop) animated:NO];
        scrollView.bouncesZoom = NO;
        scrollViewHelper.originHeaderY = HUGE_VAL;
        
        [commonSuperView addSubview:headerConfig.backgroundView];
        [scrollView addSubview:headerConfig.frontView];
        __weak typeof(scrollView) weakScrollView = scrollView;

        if ([scrollView isKindOfClass:[UITableView class]] ||
            [scrollView isKindOfClass:[UICollectionView class]]) {
            [scrollView aspect_hookSelector:@selector(reloadData) withOptions:AspectPositionAfter usingBlock:^(){
                [weakScrollView insertSubview:headerConfig.backgroundView atIndex:0];
            } error:nil];
        }
        [scrollView vv_addObserver:scrollViewHelper forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew withBlock:^(NSDictionary * _Nonnull change, void * _Nonnull context) {
            [scrollViewHelper scrollViewDidSroll:weakScrollView superViewInsetHeight:0];
        }];

    }
    return scrollViewHelper;
}

- (void)scrollViewDidSroll:(UIScrollView *)scrollView superViewInsetHeight:(CGFloat)insetHeight{
    
    CGPoint point = scrollView.contentOffset;
    CGFloat originOffsetY = point.y+insetHeight;
    if (self.originHeaderY == HUGE_VAL) {
        if (self.extraHeaderViewConfig.frontView) {
            self.originHeaderY = self.extraHeaderViewConfig.frontView.frame.origin.y;
        }
    }
    
    if (self.extraHeaderViewConfig) {
        CGRect front_rect = self.extraHeaderViewConfig.frontView.frame;
        CGRect frame = self.extraHeaderViewConfig.frontView.frame;
        CGPoint origin = frame.origin;
        CGSize size = frame.size;
        if (scrollView.contentOffset.y > - CGRectGetHeight(frame)) {
            origin.y = - CGRectGetHeight(frame);
            size.height = CGRectGetHeight(frame);
        } else {
            origin.y = scrollView.contentOffset.y;
            size.height = - scrollView.contentOffset.y;
        }
//
//        if (originOffsetY<= -self.defautHeaderSize.height) {
//            front_rect.origin.y = fabs(originOffsetY)-self.defautHeaderSize.height;
//        }else{
//            front_rect.origin.y = -(originOffsetY+self.defautHeaderSize.height);
//        }
//        front_rect.size.height = self.defautHeaderSize.height;
//        self.extraHeaderViewConfig.frontView.frame = front_rect;
//
//        CGRect background_rect = self.extraHeaderViewConfig.frontView.frame;
//       if (originOffsetY<= -self.defautHeaderSize.height) {
//           background_rect.origin.y = self.originHeaderY;
//           background_rect.size.height = - originOffsetY;
//       }else if (originOffsetY> -self.defautHeaderSize.height){
//           background_rect.origin.y = -(originOffsetY+self.defautHeaderSize.height);
//           background_rect.size.height = self.defautHeaderSize.height;
//       }
        frame.origin = origin;
        frame.size = size;
        self.extraHeaderViewConfig.backgroundView.frame = frame;
    }
}

@end
