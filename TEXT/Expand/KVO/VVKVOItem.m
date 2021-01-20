//
//  VVKVOItem.m
//  vv_rootlib_ios
//
//  Created by JackLee on 2020/6/13.
//

#import "VVKVOItem.h"
#import "VVKVOObserver.h"
#import "NSObject+VVKVOHelper.h"
#import "VVKVOItemManager.h"

@interface VVKVOItem()
/// 观察者
@property (nonatomic, strong, nonnull, readwrite) VVKVOObserver *kvoObserver;
/// 被观察的对象
@property (nonatomic, weak, nullable, readwrite) __kindof NSObject *observered;
/// 被观察的对象的内存地址
@property (nonatomic, copy, nullable, readwrite)  NSString * observered_address;
/// 监听的keyPath
@property (nonatomic, copy, nonnull, readwrite) NSString *keyPath;
/// 上下文
@property (nonatomic, nullable, readwrite) void *context;
/// 回调
@property (nonatomic, copy, readwrite) void(^block)(NSString *keyPath, NSDictionary *change, void *context);

@end

@implementation VVKVOItem

/// 非数组的监听
+ (instancetype)initWith_kvoObserver:(nonnull VVKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                             context:(nullable void *)context
                               block:(nullable void(^)(NSString *keyPath, NSDictionary *change, void *context))block;
{
    VVKVOItem *item = [[self alloc] init];
    if (item) {
        item.kvoObserver = kvoObserver;
        item.observered = observered;
        item.observered_address = [NSString stringWithFormat:@"%p",observered];
        item.keyPath = keyPath;
        item.context = context;
        item.block = block;
    }
    return item;
}



- (BOOL)valid
{
    return self.kvoObserver.originObserver && self.observered;
}

@end


@interface VVKVOArrayElement()

@property (nonatomic, strong, nonnull, readwrite) __kindof NSObject *object;

@property (nonatomic, assign, readwrite) NSInteger index;


@end

@implementation VVKVOArrayElement

+ (instancetype)elementWithObject:(__kindof NSObject *)object
                            index:(NSInteger)index
{
    VVKVOArrayElement *element = [[self alloc] init];
    if (element) {
        element.object = object;
        element.index = index;
    }
    return element;
}

@end

@implementation VVKVOArrayChangeModel

@end

@interface VVKVOArrayItem()

/// 被监听的属性对应的对象
@property (nonatomic, weak, nullable, readwrite) __kindof NSArray *observered_property;

///监听选项
@property (nonatomic, assign, readwrite) NSKeyValueObservingOptions options;

/// 数组元素需要监听的keyPath的数组
@property (nonatomic, strong, nullable, readwrite) NSArray *elementKeyPaths;
/// 回调
@property (nonatomic, copy, readwrite) void(^detailBlock)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context);

/// 被监听的元素map   key:element   value: 添加监听的次数
@property (nonatomic, strong, nonnull, readwrite) NSMapTable *observered_elementMap;

@end


@implementation VVKVOArrayItem

/// 数组的监听
+ (instancetype)initWith_kvoObserver:(nonnull VVKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                             context:(nullable void *)context
                             options:(NSKeyValueObservingOptions)options
                 observered_property:(nullable __kindof NSObject *)observered_property
                     elementKeyPaths:(nullable NSArray *)elementKeyPaths
                         detailBlock:(nullable void(^)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context))detailBlock;
{
    VVKVOArrayItem *item = [[self alloc] init];
    if (item) {
        item.kvoObserver = kvoObserver;
        item.observered = observered;
        item.observered_address = [NSString stringWithFormat:@"%p",observered];
        item.keyPath = keyPath;
        item.context = context;
        item.options = options;
        item.observered_property = observered_property;
        item.elementKeyPaths = elementKeyPaths;
        item.detailBlock = detailBlock;
        item.observered_elementMap = [NSMapTable strongToStrongObjectsMapTable];
    }
    return item;
}

- (void)addObserverOfElement:(nonnull __kindof NSObject *)element
{
    if (!self.elementKeyPaths
        || self.elementKeyPaths.count == 0) {
        return;
    }
    NSNumber *value = [self.observered_elementMap objectForKey:element];
    if (value) {
        NSUInteger observeredCount = [value unsignedIntegerValue];
        observeredCount += self.elementKeyPaths.count;
        [self.observered_elementMap setObject:@(observeredCount) forKey:element];
    } else {
        for (NSString *keyPath in self.elementKeyPaths) {
            [element addObserver:self.kvoObserver forKeyPath:keyPath options:self.options context:self.context];
            self.kvoObserver.observerCount++;
        }
        NSUInteger observeredCount = self.elementKeyPaths.count;
        [self.observered_elementMap setObject:@(observeredCount) forKey:element];
    }
    
}

- (void)removeObserverOfElement:(nonnull __kindof NSObject *)element
{
    NSNumber *value = [self.observered_elementMap objectForKey:element];
    if (value) {
        NSUInteger observeredCount = [value unsignedIntegerValue];
        observeredCount -= self.elementKeyPaths.count;
        if (observeredCount > 0) {
            [self.observered_elementMap setObject:@(observeredCount) forKey:element];
        } else {
            for (NSString *keyPath in self.elementKeyPaths) {
                [element removeObserver:self.kvoObserver forKeyPath:keyPath context:self.context];
                self.kvoObserver.observerCount--;
            }
            [self.observered_elementMap removeObjectForKey:element];
        }
    }
}

- (nullable NSArray <VVKVOArrayElement *>*)kvoElementsWithElement:(nonnull __kindof NSObject *)element
{
    NSMutableArray *kvoElements = nil;
    NSArray *observered_property = self.observered_property;
    if (!observered_property || observered_property.count == 0) {
        return kvoElements;
    }
    [VVKVOItemManager lock];
    NSArray *elements = [observered_property copy];
    if ([elements containsObject:element]) {
        kvoElements = [NSMutableArray new];
        for (NSInteger i = 0; i < elements.count; i++) {
            __kindof NSObject *tmpElement = elements[i];
            if ([tmpElement isEqual:element]) {
                NSInteger index = i;
                VVKVOArrayElement *kvoElement = [VVKVOArrayElement elementWithObject:element index:index];
                [kvoElements addObject:kvoElement];
            }
        }
    }
    [VVKVOItemManager unLock];
    return kvoElements;
}


@end
