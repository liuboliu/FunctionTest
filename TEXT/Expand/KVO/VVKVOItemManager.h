//
//  VVKVOItemManager.h
//  VVRootLib
//
//  Created by JackLee on 2019/10/15.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VVKVOItem,VVKVOArrayItem,VVKVOObserver;

@interface VVKVOItemManager : NSObject

+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)init NS_UNAVAILABLE;

+ (instancetype)sharedManager;

+ (void)lock;

+ (void)unLock;

+ (void)addItem:(VVKVOItem *)item;

+ (void)removeItem:(VVKVOItem *)item;

/// 判断是否存在item
/// @param observer 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
/// @param context context
+ (nullable VVKVOItem *)isContainItemWithObserver:(__kindof NSObject *)observer
                                       observered:(__kindof NSObject *)observered
                                          keyPath:(NSString *)keyPath
                                          context:(nullable void *)context;

/// 是否存在VVKVOArrayItem
/// @param observer 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
/// @param context context
+ (nullable VVKVOArrayItem *)isContainArrayItemWithObserver:(__kindof NSObject *)observer
                                                 observered:(__kindof NSObject *)observered
                                                    keyPath:(NSString *)keyPath
                                                    context:(nullable void *)context;

/// 是否存在item
/// @param observer 观察者
/// @param observered 被观察者
+ (BOOL)isContainItemWithObserver:(__kindof NSObject *)observer
                       observered:(__kindof NSObject *)observered;

/// 根据kvoObserver判断是否存在对应的item
/// @param kvoObserver kvoObserver
/// @param observered 被观察者
+ (nullable __kindof VVKVOItem *)isContainItemWith_kvoObserver:(VVKVOObserver *)kvoObserver
                                                    observered:(__kindof NSObject *)observered;

/// 判断是否存在item
/// @param kvoObserver 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
/// @param context context
+ (nullable VVKVOItem *)isContainItemWith_kvoObserver:(VVKVOObserver *)kvoObserver
                                           observered:(__kindof NSObject *)observered
                                              keyPath:(NSString *)keyPath
                                              context:(nullable void *)context;
/// 判断是否存在arrayItem
/// @param kvoObserver kvoObserver
/// @param element_observered element_observered
/// @param keyPath keyPath
/// @param context context
+ (nullable VVKVOArrayItem *)isContainArrayItemWith_kvoObserver:(VVKVOObserver *)kvoObserver                                                                                element_observered:(__kindof NSObject *)element_observered
                                                        keyPath:(NSString *)keyPath
                                                        context:(nullable void *)context;

/// 获取item列表
/// @param observer 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
+ (NSArray <VVKVOItem *>*)itemsWithObserver:(__kindof NSObject *)observer
                                 observered:(__kindof NSObject *)observered
                                    keyPath:(nullable NSString *)keyPath;

/// 获取item列表
/// @param observered 被观察者
+ (NSArray <VVKVOItem *>*)itemsOfObservered:(__kindof NSObject *)observered;

/// 获取item列表
/// @param observered 被观察者
/// @param keyPath keyPath
+ (NSArray <VVKVOItem *>*)itemsOfObservered:(__kindof NSObject *)observered
                                    keyPath:(nullable NSString *)keyPath;
/// 获取item列表
/// @param observer 观察者
/// @param observered 被观察者
+ (NSArray <__kindof VVKVOItem *>*)itemsOfObserver:(__kindof NSObject *)observer
                                        observered:(__kindof NSObject *)observered;

/// 获取item列表
/// @param kvoObserver 真正的观察者
/// @param observered 被观察者
+ (NSArray <__kindof VVKVOItem *>*)itemsOf_kvoObserver:(__kindof NSObject *)kvoObserver
                                            observered:(__kindof NSObject *)observered;

/// 获取VVKVOArrayItem列表
/// @param observered_property 被观察者对应的属性对象
+ (NSArray <VVKVOArrayItem *>*)arrayItemsOfObservered_property:(__kindof NSObject *)observered_property;

/// 获取监听者列表
/// @param observered 被观察者
/// @param keyPath keyPath
+ (NSArray <__kindof NSObject *>*)observersOfObservered:(__kindof NSObject *)observered
                                                keyPath:(nullable NSString *)keyPath;

/// 获取被观察的keyPath列表
/// @param observered 被观察者
+ (NSArray <NSString *>*)observeredKeyPathsOfObservered:(__kindof NSObject *)observered;

/// 获取被观察keyPath列表
/// @param observered 被观察者
/// @param observer 观察者
+ (NSArray <NSString *>*)observeredKeyPathsOfObserered:(__kindof NSObject *)observered
                                              observer:(__kindof NSObject *)observer;

/// 获取被观察的keyPath列表
/// @param kvoObserver 被观察者
+ (NSArray <NSString *>*)observeredKeyPathsOf_kvoObserver:(VVKVOObserver *)kvoObserver
                                               observered:(__kindof NSObject *)observered;

/// 获取item.observered 为nil的item列表
/// @param observered 被观察者
+ (NSArray <VVKVOItem *>*)dealloc_itemsOfObservered:(__kindof NSObject *)observered;

@end

NS_ASSUME_NONNULL_END
