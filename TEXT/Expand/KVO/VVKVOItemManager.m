//
//  VVKVOItemManager.m
//  VVRootLib
//
//  Created by JackLee on 2019/10/15.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import "VVKVOItemManager.h"
#import "NSObject+VVKVOHelper.h"
#import <objc/runtime.h>
#import "VVKVOItem.h"

static const void *vv_kvo_items_key = "vv_kvo_items_key";

@interface NSObject (VVKVOItemManager)

@property (nonatomic, strong)NSMutableArray <__kindof VVKVOItem *>*vv_kvo_items;

@end

@implementation NSObject(VVKVOItemManager)

- (void)setVv_kvo_items:(NSMutableArray<__kindof VVKVOItem *> *)vv_kvo_items
{
    objc_setAssociatedObject(self, vv_kvo_items_key, vv_kvo_items, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray<__kindof VVKVOItem *> *)vv_kvo_items
{
    NSMutableArray *tmpArray = objc_getAssociatedObject(self, vv_kvo_items_key);
    if (!tmpArray) {
        tmpArray = [NSMutableArray new];
        [self setVv_kvo_items:tmpArray];
    }
    return tmpArray;
}

@end

#pragma mark - - VVKVOItemManager - -

@interface VVKVOItemManager()

/// 所有的VVKVOArrayItem
@property (nonatomic, strong) NSMutableArray <VVKVOArrayItem *>*arrayItems;

@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation VVKVOItemManager

+ (instancetype)sharedManager
{
    static VVKVOItemManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
        _manager.lock = [[NSRecursiveLock alloc] init];
        _manager.arrayItems = [NSMutableArray new];
    });
    return _manager;
}

+ (void)lock
{
    [[VVKVOItemManager sharedManager].lock lock];
}

+ (void)unLock
{
    [[VVKVOItemManager sharedManager].lock unlock];
}

+ (void)addItem:(__kindof VVKVOItem *)item
{
    if ([item isKindOfClass:[VVKVOArrayItem class]]) {
        [self addArrayItem:item];
    } else {
        if (item
            && item.observered
            && ![item.observered.vv_kvo_items containsObject:item]) {
            [item.observered.vv_kvo_items addObject:item];
        }
    }
}

+ (void)removeItem:(__kindof VVKVOItem *)item
{
    if ([item isKindOfClass:[VVKVOArrayItem class]]) {
        [self removeArrayItem:item];
    } else {
        if (item
            && item.observered
            && [item.observered.vv_kvo_items containsObject:item]) {
            [item.observered.vv_kvo_items removeObject:item];
        }
    }
}

+ (void)addArrayItem:(VVKVOArrayItem *)arrayItem
{
    if (![[VVKVOItemManager sharedManager].arrayItems containsObject:arrayItem]) {
        [[VVKVOItemManager sharedManager].arrayItems addObject:arrayItem];
    }
}

+ (void)removeArrayItem:(VVKVOArrayItem *)arrayItem
{
    if ([[VVKVOItemManager sharedManager].arrayItems containsObject:arrayItem]) {
        [[VVKVOItemManager sharedManager].arrayItems removeObject:arrayItem];
    }
}

+ (nullable __kindof VVKVOItem *)isContainItemWithObserver:(__kindof NSObject *)observer
                                                observered:(__kindof NSObject *)observered
                                                   keyPath:(NSString *)keyPath
                                                   context:(nullable void *)context
{
    if (!observer || !observered || !keyPath) {
        return nil;
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    [self unLock];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
            && [keyPath isEqualToString:item.keyPath]
            && context == item.context) {
            return item;
        }
    }
    return nil;
}

+ (nullable VVKVOArrayItem *)isContainArrayItemWithObserver:(__kindof NSObject *)observer
                                                 observered:(__kindof NSObject *)observered
                                                    keyPath:(NSString *)keyPath
                                                    context:(nullable void *)context
{
    if (!observer || !observered || !keyPath) {
        return nil;
    }
    [self lock];
    NSArray *items = [[VVKVOItemManager sharedManager].arrayItems copy];
    [self unLock];
    for (VVKVOArrayItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
            && [keyPath isEqualToString:item.keyPath]
            && context == item.context) {
            return item;
        }
    }
    return nil;
}

+ (BOOL)isContainItemWithObserver:(__kindof NSObject *)observer
                       observered:(__kindof NSObject *)observered
{
    if (!observer || !observered) {
        return NO;
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    [self unLock];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            return YES;
        }
    }
    return NO;
}

+ (nullable __kindof VVKVOItem *)isContainItemWith_kvoObserver:(VVKVOObserver *)kvoObserver
                                                    observered:(__kindof NSObject *)observered
{
    if (!kvoObserver || !observered) {
        return nil;
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    [self unLock];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [kvoObserver isEqual:item.kvoObserver]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            return item;
        }
    }
    return nil;
}

+ (nullable __kindof VVKVOItem *)isContainItemWith_kvoObserver:(VVKVOObserver *)kvoObserver
                                                    observered:(__kindof NSObject *)observered
                                                       keyPath:(NSString *)keyPath
                                                       context:(nullable void *)context
{
    if (!kvoObserver || !observered || !keyPath) {
        return nil;
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    [self unLock];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [kvoObserver isEqual:item.kvoObserver]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
            && [keyPath isEqualToString:item.keyPath]
            && context == item.context) {
            return item;
        }
    }
    return nil;
}

+ (nullable VVKVOArrayItem *)isContainArrayItemWith_kvoObserver:(VVKVOObserver *)kvoObserver
                                             element_observered:(__kindof NSObject *)element_observered
                                                        keyPath:(NSString *)keyPath
                                                        context:(nullable void *)context
{
    
    if (kvoObserver.observerCount > 1) { // observered is an element of a array
        [self lock];
        NSMutableArray *items = [[VVKVOItemManager sharedManager].arrayItems copy];
        [self unLock];
        for (VVKVOArrayItem *item in items) {
            if (item.valid
                && [kvoObserver isEqual:item.kvoObserver]
                && [item.elementKeyPaths containsObject:keyPath]
                && context == item.context) {
                return item;
            }
        }
        
    }
    return nil;
}

+ (NSArray <__kindof VVKVOItem *>*)itemsWithObserver:(__kindof NSObject *)observer
                                          observered:(__kindof NSObject *)observered
                                             keyPath:(nullable NSString *)keyPath
{
    if (!observer || !observered) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (keyPath) {
                if ([keyPath isEqualToString:item.keyPath]) {
                    if (![tmpArray containsObject:item]) {
                        [tmpArray addObject:item];
                    }
                }
            } else {
                if (![tmpArray containsObject:item]) {
                    [tmpArray addObject:item];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <VVKVOItem *>*)itemsOfObservered:(__kindof NSObject *)observered
{
    return [self itemsOfObservered:observered keyPath:nil];
}

+ (NSArray <__kindof VVKVOItem *>*)itemsOfObservered:(__kindof NSObject *)observered
                                             keyPath:(nullable NSString *)keyPath
{
    if (!observered) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (keyPath) {
                if ([keyPath isEqualToString:item.keyPath]) {
                    if (![tmpArray containsObject:item]) {
                        [tmpArray addObject:item];
                    }
                }
            } else {
                if (![tmpArray containsObject:item]) {
                    [tmpArray addObject:item];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <__kindof VVKVOItem *>*)itemsOfObserver:(__kindof NSObject *)observer
                                        observered:(__kindof NSObject *)observered
{
    if (!observer) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (![tmpArray containsObject:item]) {
                [tmpArray addObject:item];
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <__kindof VVKVOItem *>*)itemsOf_kvoObserver:(__kindof NSObject *)kvoObserver
                                            observered:(__kindof NSObject *)observered
{
    if (!kvoObserver) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [kvoObserver isEqual:item.kvoObserver]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (![tmpArray containsObject:item]) {
                [tmpArray addObject:item];
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <VVKVOArrayItem *>*)arrayItemsOfObservered_property:(__kindof NSObject *)observered_property
{
    if (!observered_property) {
        return @[];
    }
    [self lock];
    NSArray *items = [[VVKVOItemManager sharedManager].arrayItems copy];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (VVKVOArrayItem *item in items) {
        if (item.valid
            && [observered_property isEqual:item.observered_property]) {
            if (![tmpArray containsObject:item]) {
                [tmpArray addObject:item];
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <__kindof NSObject *>*)observersOfObservered:(__kindof NSObject *)observered
                                                keyPath:(nullable NSString *)keyPath
{
    if (!observered) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableSet *set = [NSMutableSet new];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (keyPath) {
                if ([keyPath isEqualToString:item.keyPath]) {
                    [set addObject:item.kvoObserver.originObserver];
                }
            } else {
                [set addObject:item.kvoObserver.originObserver];
            }
        }
    }
    [self unLock];
    return [set allObjects];
}

+ (NSArray <NSString *>*)observeredKeyPathsOfObservered:(__kindof NSObject *)observered
{
    if (!observered) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (item.keyPath) {
                if (![tmpArray containsObject:item.keyPath]) {
                    [tmpArray addObject:item.keyPath];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <NSString *>*)observeredKeyPathsOfObserered:(__kindof NSObject *)observered
                                              observer:(__kindof NSObject *)observer
{
    if (!observer || !observered) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
            && [[NSString stringWithFormat:@"%p",observer]
                isEqualToString:item.kvoObserver.originObserver_address]) {
            if (item.keyPath) {
                if (![tmpArray containsObject:item.keyPath]) {
                    [tmpArray addObject:item.keyPath];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <NSString *>*)observeredKeyPathsOf_kvoObserver:(VVKVOObserver *)kvoObserver
                                               observered:(__kindof NSObject *)observered
{
    if (!kvoObserver || !observered) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof VVKVOItem *item in items) {
        if (item.valid
            && [kvoObserver isEqual:item.kvoObserver]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (item.keyPath) {
                if (![tmpArray containsObject:item.keyPath]) {
                    [tmpArray addObject:item.keyPath];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <VVKVOItem *>*)dealloc_itemsOfObservered:(__kindof NSObject *)observered
{
    
    if (!observered) {
        return @[];
    }
    [self lock];
    NSArray *vv_kvo_items = [observered.vv_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:vv_kvo_items];
    [items addObjectsFromArray:[VVKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof VVKVOItem *item in items) {
        if (!item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (![tmpArray containsObject:item]) {
                [tmpArray addObject:item];
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

@end
