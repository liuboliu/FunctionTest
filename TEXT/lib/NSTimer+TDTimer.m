//
//  NSTimer+tdTimer.m
//  Vova
//
//  Created by chuxiao on 2018/8/2.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "NSTimer+TDTimer.h"

@interface TDTimerTarget ()

@property (nonatomic,weak) id sourceTarget;
@property (nonatomic,copy) void(^actionBlock)(NSTimer *timer);
@property (nonatomic, assign) SEL actionSelector;

@end

@implementation TDTimerTarget

- (instancetype)initWithSelector:(SEL)aSelector  sourceTarget:(id)sourceTarget{
    self = [super init];
    if (self) {
        self.actionBlock = nil;
        self.sourceTarget = sourceTarget;
        self.actionSelector = aSelector;
    }
    return self;
}

- (instancetype)initWithBlock:(void(^)(NSTimer *timer))block sourceTarget:(id)sourceTarget{
    self = [super init];
    if (self) {
        self.actionBlock = block;
        self.sourceTarget =sourceTarget;
    }
    return self;
}

- (void)timerAction:(NSTimer *)timer{
    if (self.sourceTarget == nil) {
        [timer invalidate];
        timer = nil;
    }else{
        if (self.actionBlock) {
            self.actionBlock(timer);
        }else{
            IMP imp = [self.sourceTarget methodForSelector:self.actionSelector];
            void (*func)(id, SEL,NSTimer *) = (void *)imp;
            func(self.sourceTarget, self.actionSelector,timer);
        }
    }
}

@end


#pragma mark - NSTimer Category

@implementation NSTimer (TDTimer)

+ (NSTimer *)td_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        target:(id)target
                                        repeat:(BOOL)repeat
                                         block:(void(^)(NSTimer *timer))block
{
    TDTimerTarget *timerTarget = [[TDTimerTarget alloc] initWithBlock:block sourceTarget:target];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:timerTarget selector:@selector(timerAction:) userInfo:nil repeats:YES];
    return timer;
}

+ (NSTimer *)td_timerWithTimeInterval:(NSTimeInterval)interval
                               target:(id)target
                               repeat:(BOOL)repeat
                                block:(void(^)(NSTimer *timer))block
{
    TDTimerTarget *timerTarget = [[TDTimerTarget alloc] initWithBlock:block sourceTarget:target];
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:timerTarget selector:@selector(timerAction:) userInfo:nil repeats:YES];
    return timer;
}

+ (NSTimer *)td_timerWithTimeInterval:(NSTimeInterval)interval
                               target:(id)target
                             selector:(SEL)selector
                             userInfo:(nullable id)userInfo
                              repeats:(BOOL)repeat
{
    TDTimerTarget *timerTarget = [[TDTimerTarget alloc] initWithSelector:selector sourceTarget:target];
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:timerTarget selector:@selector(timerAction:) userInfo:userInfo repeats:repeat];
    return timer;
}

@end
