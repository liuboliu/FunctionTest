//
//  VVKVOItem.h
//  vv_rootlib_ios
//
//  Created by JackLee on 2020/6/13.
//

#import <Foundation/Foundation.h>
#import "VVKVOObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVKVOItem : NSObject
/// 观察者
@property (nonatomic, strong, nonnull, readonly) VVKVOObserver *kvoObserver;
/// 被观察者
@property (nonatomic, weak, nullable, readonly) __kindof NSObject *observered;
///被观察者的内存地址
@property (nonatomic, copy, nullable, readonly) NSString *observered_address;
/// 监听的keyPath
@property (nonatomic, copy, nonnull, readonly) NSString *keyPath;
/// 上下文
@property (nonatomic, nullable, readonly) void *context;
/// 回调
@property (nonatomic, copy, readonly) void(^block)(NSString *keyPath, NSDictionary *change, void *context);
/// 是否有效
@property (nonatomic, assign, readonly) BOOL valid;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init ;

/// 非数组的监听
+ (instancetype)initWith_kvoObserver:(nonnull VVKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                             context:(nullable void *)context
                               block:(nullable void(^)(NSString *keyPath,  NSDictionary *change, void *context))block;
@end



typedef NS_ENUM(NSInteger,VVKVOArrayChangeType) {
    /// 缺省值 没有任何改变
    VVKVOArrayChangeTypeNone = 0,
    /// 根据index增加元素
    VVKVOArrayChangeTypeAddAtIndex,
    /// 尾部增加元素
    VVKVOArrayChangeTypeAddTail,
    /// 根据index移除元素
    VVKVOArrayChangeTypeRemoveAtIndex,
    /// 移除尾部元素
    VVKVOArrayChangeTypeRemoveTail,
    /// 替换元素
    VVKVOArrayChangeTypeReplace,
    /// 元素内容改变，指针不变
    VVKVOArrayChangeTypeElement,
};



@interface VVKVOArrayElement : NSObject

@property (nonatomic, strong, nonnull, readonly) __kindof NSObject *object;

@property (nonatomic, assign, readonly) NSInteger index;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)elementWithObject:(__kindof NSObject *)object
                            index:(NSInteger)index;

@end



@interface VVKVOArrayChangeModel : NSObject

@property (nonatomic, assign) VVKVOArrayChangeType changeType;

@property (nonatomic, strong) NSArray <VVKVOArrayElement *>*changedElements;
@end

@interface VVKVOArrayItem : VVKVOItem

/// 被监听的属性对应的对象
@property (nonatomic, weak, nullable, readonly) __kindof NSArray *observered_property;
///监听选项
@property (nonatomic, assign, readonly) NSKeyValueObservingOptions options;
/// 数组元素需要监听的keyPath的数组
@property (nonatomic, strong, nullable, readonly) NSArray *elementKeyPaths;

/// 被监听的元素map   key:element   value: 添加监听的次数
@property (nonatomic, strong, nonnull, readonly) NSMapTable *observered_elementMap;
/// 回调
@property (nonatomic, copy, readonly) void(^detailBlock)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context);

+ (instancetype)initWith_kvoObserver:(nonnull VVKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                             context:(nullable void *)context
                             options:(NSKeyValueObservingOptions)options
                 observered_property:(nullable __kindof NSObject *)observered_property
                     elementKeyPaths:(nullable NSArray *)elementKeyPaths
                         detailBlock:(nullable void(^)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context))detailBlock;

- (void)addObserverOfElement:(nonnull __kindof NSObject *)element;

- (void)removeObserverOfElement:(nonnull __kindof NSObject *)element;

- (nullable NSArray <VVKVOArrayElement *>*)kvoElementsWithElement:(nonnull __kindof NSObject *)element;

@end

NS_ASSUME_NONNULL_END
