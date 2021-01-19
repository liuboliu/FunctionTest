//
//  NSObject+VVKVOHelper.m
//  VVRootLib
//
//  Created by JackLee on 2019/8/27.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import "NSObject+VVKVOHelper.h"
#import "VVKVOItemManager.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
static const void *is_vv_observeredKey = &is_vv_observeredKey;
static const void *is_vv_deallocedKey = "is_vv_deallocedKey";


@implementation NSObject (VVKVOHelper)

+ (void)load
{
    [self vv_exchangeDeallocMethod];
}
#pragma mark - - setter - -
- (void)setIs_vv_observered:(BOOL)is_vv_observered
{
    objc_setAssociatedObject(self, is_vv_observeredKey, @(is_vv_observered), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIs_vv_dealloced:(BOOL)is_vv_dealloced
{
    objc_setAssociatedObject(self, is_vv_deallocedKey, @(is_vv_dealloced), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - - getter - -
- (BOOL)is_vv_observered
{
    return [objc_getAssociatedObject(self, is_vv_observeredKey) boolValue];
}

- (BOOL)is_vv_dealloced
{
    return [objc_getAssociatedObject(self, is_vv_deallocedKey) boolValue];
}

- (void)vv_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
             withBlock:(void(^)(NSDictionary *change, void *context))block
{
    [self vv_addObserver:observer forKeyPath:keyPath options:options context:nil withBlock:block];
}

- (void)vv_addObserver:(__kindof NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(nullable void *)context
             withBlock:(void(^)(NSDictionary *change, void *context))block
{
    if (!observer || !keyPath || !block) {
        return;
    }
    
    if (![VVKVOItemManager isContainItemWithObserver:observer
                                          observered:self
                                             keyPath:keyPath
                                             context:context]) {
        [VVKVOItemManager lock];
        [self setIs_vv_observered:YES];
        VVKVOObserver *kvoObserver = [VVKVOObserver initWithOriginObserver:observer];
        void(^realBlock)(NSString *keyPath, NSDictionary *change, void *context) = ^(NSString *keyPath, NSDictionary *change, void *context){
            if (block) {
                block(change,context);
            }
        };
        VVKVOItem *item = [VVKVOItem initWith_kvoObserver:kvoObserver observered:self keyPath:keyPath context:context block:realBlock];
        [VVKVOItemManager addItem:item];
        [self addObserver:kvoObserver forKeyPath:keyPath options:options context:context];
        [VVKVOItemManager unLock];
    }
}

- (void)vv_addObserver:(__kindof NSObject *)observer
           forKeyPaths:(NSArray <NSString *>*)keyPaths
               options:(NSKeyValueObservingOptions)options
               context:(nullable void *)context
       withDetailBlock:(void(^)(NSString *keyPath, NSDictionary *change, void *context))detailBlock
{
    if (!observer || !keyPaths || keyPaths.count == 0 || !detailBlock) {
        return;
    }
    
    for (NSString *keyPath in keyPaths) {
        if (![VVKVOItemManager isContainItemWithObserver:observer
                                              observered:self
                                                 keyPath:keyPath
                                                 context:context]) {
            [VVKVOItemManager lock];
            [self setIs_vv_observered:YES];
            VVKVOObserver *kvoObserver = [VVKVOObserver initWithOriginObserver:observer];
            VVKVOItem *item = [VVKVOItem initWith_kvoObserver:kvoObserver observered:self keyPath:keyPath context:context block:detailBlock];
            [VVKVOItemManager addItem:item];
            [self addObserver:kvoObserver forKeyPath:keyPath options:options context:context];
            [VVKVOItemManager unLock];
        }
    }
    
}

- (void)vv_addObserverForKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                       withBlock:(void(^)(NSDictionary *change, void *context))block
{
    [self vv_addObserver:self forKeyPath:keyPath options:options withBlock:block];
}

- (void)vv_addObserverForKeyPaths:(NSArray <NSString *>*)keyPaths
                          options:(NSKeyValueObservingOptions)options
                          context:(nullable void *)context
                  withDetailBlock:(void(^)(NSString *keyPath, NSDictionary *change, void *context))detailBlock
{
    [self vv_addObserver:self forKeyPaths:keyPaths options:options context:context withDetailBlock:detailBlock];
}

- (void)vv_addObserverForKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         context:(nullable void *)context
                       withBlock:(void(^)(NSDictionary *change, void *context))block
{
    [self vv_addObserver:self forKeyPath:keyPath options:options context:context withBlock:block];
}

- (void)vv_addObserverOptionsNewForKeyPath:(NSString *)keyPath
                                     block:(void(^)(void))block
{
    [self vv_addObserverForKeyPath:keyPath options:NSKeyValueObservingOptionNew withBlock:^(NSDictionary * _Nonnull change, void * _Nonnull context) {
        if (block) {
            block();
        }
    }];
}

- (void)vv_addObserverOptionsOldForKeyPath:(NSString *)keyPath
                                     block:(void(^)(NSDictionary * _Nonnull change))block
{
    [self vv_addObserverForKeyPath:keyPath
                           options:NSKeyValueObservingOptionOld
                         withBlock:^(NSDictionary * _Nonnull change,
                                     void * _Nonnull context)
     {
        if (block) {
            block(change);
        }
    }];
}

- (void)vv_addObserverOfArrayForKeyPath:(NSString *)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(nullable void *)context
                              withBlock:(void (^)(NSString *keyPath, NSDictionary *change,VVKVOArrayChangeModel *changedModel, void *context))block
{
    [self vv_addObserverOfArrayForKeyPath:keyPath options:options context:context elementKeyPaths:nil withBlock:block];
}

- (void)vv_addObserverOfArrayForKeyPath:(NSString *)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(nullable void *)context
                        elementKeyPaths:(nullable NSArray <NSString *>*)elementKeyPaths
                              withBlock:(void (^)(NSString *keyPath, NSDictionary *change,VVKVOArrayChangeModel *changedModel, void *context))block
{
    [self vv_addObserverOfArray:self keyPath:keyPath options:options context:context elementKeyPaths:elementKeyPaths withBlock:block];
}

- (void)vv_addObserverOfArray:(__kindof NSObject *)observer
                      keyPath:(NSString *)keyPath
                      options:(NSKeyValueObservingOptions)options
                      context:(nullable void *)context
              elementKeyPaths:(nullable NSArray <NSString *>*)elementKeyPaths
                    withBlock:(void (^)(NSString *keyPath, NSDictionary *change,VVKVOArrayChangeModel *changedModel, void *context))block
{
    if (!observer || !keyPath || !block) {
        return;
    }
    if (![VVKVOItemManager isContainArrayItemWithObserver:observer
                                               observered:self
                                                  keyPath:keyPath
                                                  context:context]) {
        [VVKVOItemManager lock];
        [self setIs_vv_observered:YES];
        VVKVOObserver *kvoObserver = [VVKVOObserver initWithOriginObserver:observer];
        NSArray *observered_property = [self valueForKeyPath:keyPath];
        if (observered_property
            && ![observered_property isKindOfClass:[NSArray class]]) {
            NSAssert(NO, @"make sure [observered_property isKindOfClass:[NSArray class]] be YES");
            return;
        }
        
        VVKVOArrayItem *item = [VVKVOArrayItem initWith_kvoObserver:kvoObserver observered:self keyPath:keyPath context:context options:options observered_property:observered_property elementKeyPaths:elementKeyPaths detailBlock:block];
        [VVKVOItemManager addItem:item];
        [self addObserver:kvoObserver forKeyPath:keyPath options:options context:context];
        NSArray *elements = [observered_property copy];
        for (NSObject *element in elements) {
            [item addObserverOfElement:element];
        }
        [VVKVOItemManager unLock];
    }
}

- (void)vv_removeObserver:(__kindof NSObject *)observer
               forKeyPath:(NSString *)keyPath
{
    [self vv_removeObserver:observer forKeyPath:keyPath context:nil];
}

- (void)vv_removeObserver:(__kindof NSObject *)observer
               forKeyPath:(NSString *)keyPath
                  context:(nullable void *)context
{
    if (!keyPath || !observer) {
        return;
    }
    VVKVOItem *item = [VVKVOItemManager isContainItemWithObserver:observer
                                                       observered:self
                                                          keyPath:keyPath
                                                          context:context];
    if (item) {
        [VVKVOItemManager lock];
        [self removeObserver:item.kvoObserver forKeyPath:keyPath context:context];
        if ([item isKindOfClass:[VVKVOArrayItem class]]) {
            VVKVOArrayItem *arrayItem = (VVKVOArrayItem *)item;
            for (__kindof NSObject *element in arrayItem.observered_property) {
                [arrayItem removeObserverOfElement:element];
            }
        }
        [VVKVOItemManager removeItem:item];
        [VVKVOItemManager unLock];
    }
}

- (void)vv_removeObserver:(__kindof NSObject *)observer
              forKeyPaths:(NSArray <NSString *>*)keyPaths
{
    for (NSString *keyPath in keyPaths) {
        NSArray <VVKVOItem *>*items = [VVKVOItemManager itemsWithObserver:observer observered:self keyPath:keyPath];
        for (VVKVOItem *item in items) {
            [self vv_remove_kvoObserverWithItem:item];
        }
    }
}

- (void)vv_removeObservers:(NSArray <__kindof NSObject *>*)observers
                forKeyPath:(NSString *)keyPath
{
    if (!keyPath) {
        return;
    }
    if (!observers) {
        [VVKVOItemManager lock];
        NSArray *items = [VVKVOItemManager itemsOfObservered:self];
        [VVKVOItemManager unLock];
        for (VVKVOItem *item in items) {
            if ([item.keyPath isEqualToString:keyPath]) {
                [self vv_remove_kvoObserverWithItem:item];
            }
        }
    } else {
        for (NSObject *observer in observers) {
            NSArray <VVKVOItem *>* items = [VVKVOItemManager itemsWithObserver:observer observered:self keyPath:keyPath];
            for (VVKVOItem *item in items) {
                [self vv_remove_kvoObserverWithItem:item];
            }
        }
        
    }
}

- (void)vv_removeObserver:(__kindof NSObject *)observer
{
    NSArray <VVKVOItem *>*items = [VVKVOItemManager itemsOfObserver:observer observered:self];
    for (VVKVOItem *item in items) {
        [self vv_remove_kvoObserverWithItem:item];
    }
}

- (void)vv_removeObservers
{
    NSArray <VVKVOItem *>*items = [VVKVOItemManager itemsOfObservered:self];
    for (VVKVOItem *item in items) {
        [self vv_remove_kvoObserverWithItem:item];
    }
}

- (NSArray <NSString *>*)vv_observeredKeyPaths
{
    NSArray <NSString *>*keyPaths = [VVKVOItemManager observeredKeyPathsOfObservered:self];
    return keyPaths;
}

- (NSArray <NSObject *>*)vv_observersOfKeyPath:(NSString *)keyPath
{
    NSArray <__kindof NSObject *>*observers = [VVKVOItemManager observersOfObservered:self keyPath:keyPath];
    return observers;
}

- (NSArray <NSString *>*)vv_keyPathsObserveredBy:(__kindof NSObject *)observer
{
    NSArray *keyPaths = [VVKVOItemManager observeredKeyPathsOfObserered:self observer:observer];
    return keyPaths;
}

#pragma mark - - private method - -
- (void)vvhook_dealloc
{
    if (![self is_vv_dealloced]) {
        [self setIs_vv_dealloced:YES];
        if ([self is_vv_observered] ) {
            [self setIs_vv_observered:NO];
            [self vv_dealloc_removeObservers];
            [self vvhook_dealloc];
            
        } else {
            [self vvhook_dealloc];
        }
    }
    
}

- (void)vv_remove_kvoObserverWithItem:(VVKVOItem *)item
{
    if (!item) {
        return;
    }
    [VVKVOItemManager lock];
    [self removeObserver:item.kvoObserver forKeyPath:item.keyPath context:item.context];
    if ([item isKindOfClass:[VVKVOArrayItem class]]) {
        VVKVOArrayItem *arrayItem = (VVKVOArrayItem *)item;
        for (__kindof NSObject *element in arrayItem.observered_property) {
            [arrayItem removeObserverOfElement:element];
        }
    }
    [VVKVOItemManager removeItem:item];
    [VVKVOItemManager unLock];
}

- (void)vv_dealloc_removeObservers
{
    NSArray <VVKVOItem *>*items = [VVKVOItemManager dealloc_itemsOfObservered:self];
    for (VVKVOItem *item in items) {
        [self vv_remove_kvoObserverWithItem:item];
    }
}


- (void)vv_exchangeDeallocMethod
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL observeredDealloc = NSSelectorFromString(@"dealloc");
        SEL vv_observerdDealloc = NSSelectorFromString(@"vvhook_dealloc");
        [NSObject exchangeInstanceMethod:[NSObject class] originalSel:observeredDealloc swizzledSel:vv_observerdDealloc];
    });
}

@end
