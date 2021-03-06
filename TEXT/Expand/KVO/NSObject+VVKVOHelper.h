//
//  NSObject+VVKVOHelper.h
//  VVRootLib
//
//  Created by JackLee on 2019/8/27.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVKVOItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (VVKVOHelper)

/**
 添加keyPath监听
 
 @param observer 观察者
 @param keyPath keyPath
 @param options options
 @param block 回调
 */
- (void)vv_addObserver:(__kindof NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
             withBlock:(void(^)(NSDictionary *change, void *context))block;

/**
 添加keyPath监听，有context
 
 @param observer 观察者
 @param keyPath keyPath
 @param options options
 @param context context
 @param block 回调
 */
- (void)vv_addObserver:(__kindof NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(nullable void *)context
             withBlock:(void(^)(NSDictionary *change, void *context))block;

/// 添加一组keyPath监听，有context
/// @param observer 观察者
/// @param keyPaths keyPath数组
/// @param options options
/// @param context context
/// @param detailBlock 回调
- (void)vv_addObserver:(__kindof NSObject *)observer
           forKeyPaths:(NSArray <NSString *>*)keyPaths
               options:(NSKeyValueObservingOptions)options
               context:(nullable void *)context
       withDetailBlock:(void(^)(NSString *keyPath, NSDictionary *change, void *context))detailBlock;

/**
 添加keyPath监听,观察者是自己
 
 @param keyPath keyPath
 @param options options
 @param block 回调
 */
- (void)vv_addObserverForKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                       withBlock:(void(^)(NSDictionary *change, void *context))block;

/**
 添加keyPath监听,观察者是自己，有context
 
 @param keyPath keyPath
 @param options options
 @param context context
 @param block 回调
 */
- (void)vv_addObserverForKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         context:(nullable void *)context
                       withBlock:(void(^)(NSDictionary *change, void *context))block;

/// 添加一组keyPath监听,观察者是自己,有context
/// @param keyPaths keyPath数组
/// @param options options
/// @param context context
/// @param detailBlock 回调
- (void)vv_addObserverForKeyPaths:(NSArray <NSString *>*)keyPaths
                          options:(NSKeyValueObservingOptions)options
                          context:(nullable void *)context
                  withDetailBlock:(void(^)(NSString *keyPath, NSDictionary *change, void *context))detailBlock;


/**
 添加keyPath监听,观察者是自己,此方法监听新值
 
 @param keyPath keyPath
 @param block 回调
 */
- (void)vv_addObserverOptionsNewForKeyPath:(NSString *)keyPath
                                     block:(void(^)(void))block;

/**
 添加keyPath监听,观察者是自己,此方法监听旧值
 
 @param keyPath keyPath
 @param block 回调
 */
- (void)vv_addObserverOptionsOldForKeyPath:(NSString *)keyPath
                                     block:(void(^)(NSDictionary * _Nonnull change))block;

/// 监听数组的变化，不监听数组元素属性的变化
/// @param keyPath keyPath，keyPath对应的属性是数组
/// @param options options
/// @param context context
/// @param block block
- (void)vv_addObserverOfArrayForKeyPath:(NSString *)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(nullable void *)context
                              withBlock:(void (^)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context))block;

/// 监听数组的变化，同时监听数组元素属性的变化,观察者是自己
/// @param keyPath keyPath，keyPath对应的属性是数组
/// @param options options
/// @param context context
/// @param elementKeyPaths elementKeyPaths 数组的元素对应的keypath组成的数组
/// @param block block
- (void)vv_addObserverOfArrayForKeyPath:(NSString *)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(nullable void *)context
                        elementKeyPaths:(nullable NSArray <NSString *>*)elementKeyPaths
                              withBlock:(void (^)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context))block;

/// 监听数组的变化，同时监听数组元素属性的变化
/// @param observer 观察者
/// @param keyPath keyPath keyPath，keyPath对应的属性是数组
/// @param options options
/// @param context context
/// @param elementKeyPaths elementKeyPaths 数组的元素对应的keypath组成的数组
/// @param block block
- (void)vv_addObserverOfArray:(__kindof NSObject *)observer
                      keyPath:(NSString *)keyPath
                      options:(NSKeyValueObservingOptions)options
                      context:(nullable void *)context
              elementKeyPaths:(nullable NSArray <NSString *>*)elementKeyPaths
                    withBlock:(void (^)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context))block;

/**
 移除keyPath监听
 
 @param observer 观察者
 @param keyPath keyPath
 */
- (void)vv_removeObserver:(__kindof NSObject *)observer
               forKeyPath:(NSString *)keyPath;

/// 移除keyPath监听,有context
/// @param observer 观察者
/// @param keyPath keyPath
/// @param context context
- (void)vv_removeObserver:(__kindof NSObject *)observer
               forKeyPath:(NSString *)keyPath
                  context:(nullable void *)context;

/**
 移除某个observer下的对应的keyPath列表监听
 
 @param observer 观察者
 @param keyPaths keyPath组成的数组
 */
- (void)vv_removeObserver:(__kindof NSObject *)observer
              forKeyPaths:(NSArray <NSString *>*)keyPaths;

/**
 移除某个keyPath的obsevers对应的监听
 如果observers为nil，那么remove掉某个keyPath的所有obsevers对应的监听
 
 @param observers 观察者数组
 @param keyPath keyPath
 */
- (void)vv_removeObservers:(NSArray <__kindof NSObject *>*)observers
                forKeyPath:(NSString *)keyPath;

/**
 移除特定观察者
 @param observer 观察者
*/
- (void)vv_removeObserver:(__kindof NSObject *)observer;

/**
 移除所有通过vv_前缀添加的观察者，默认在被观察的对象dealloc的时候调用
 */
- (void)vv_removeObservers;

/**
 所有的被监听的keyPath列表
 
 @return 被监听的keyPath组成的列表
 */
- (NSArray <NSString *>*)vv_observeredKeyPaths;

/// 监听某一个属性的所有监听者的列表
/// @param keyPath keyPath
- (NSArray <NSObject *>*)vv_observersOfKeyPath:(NSString *)keyPath;

/**
 某个观察者监听的keyPath组成的列表
 
 @param observer 观察者
 @return keyPath组成的列表
 */
- (NSArray <NSString *>*)vv_keyPathsObserveredBy:(__kindof NSObject *)observer;

@end

NS_ASSUME_NONNULL_END
