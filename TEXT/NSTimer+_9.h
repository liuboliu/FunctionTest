//
//  NSTimer+_9.h
//  TEXT
//
//  Created by 刘博 on 2020/7/19.
//  Copyright © 2020 刘博. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (_9)

+ (NSTimer *)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval )interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
