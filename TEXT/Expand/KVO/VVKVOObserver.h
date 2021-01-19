//
//  VVKVOObserver.h
//  vv_rootlib_ios
//
//  Created by JackLee on 2020/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVKVOObserver : NSObject

@property (nonatomic, weak, nullable, readonly) __kindof NSObject *originObserver;
@property (nonatomic, copy, nullable, readonly) NSString *originObserver_address;
@property (nonatomic, assign) NSUInteger observerCount;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)initWithOriginObserver:(__kindof NSObject *)originObserver;

@end

NS_ASSUME_NONNULL_END
