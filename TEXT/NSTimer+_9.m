//
//  NSTimer+_9.m
//  TEXT
//
//  Created by 刘博 on 2020/7/19.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "NSTimer+_9.h"

@implementation NSTimer (_9)

+ (NSTimer *)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval )interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(handle:) userInfo:block repeats:repeats];
}

+ (void)handle:(NSTimer *)timer
{
    void (^block) (void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end
