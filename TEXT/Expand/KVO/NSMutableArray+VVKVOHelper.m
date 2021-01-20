//
//  NSMutableArray+VVKVOHelper.m
//  kvo_rootlib_ios
//
//  Created by JackLee on 2020/5/7.
//

#import "NSMutableArray+VVKVOHelper.h"
#import "VVKVOItem.h"
#import "VVKVOItemManager.h"

@implementation NSMutableArray (VVKVOHelper)

- (void)kvo_addObject:(id)anObject
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
#endif
    if (anObject) {
        NSArray <VVKVOArrayItem *>*items = [VVKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSInteger index = [self count];
            VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
            changedModel.changeType = VVKVOArrayChangeTypeAddTail;
            VVKVOArrayElement *element = [VVKVOArrayElement elementWithObject:anObject index:index];
            changedModel.changedElements = @[element];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(VVKVOArrayItem * _Nullable item) {
                [self addObject:anObject];
                if (item) {
                    [item addObserverOfElement:element];
                }
                return YES;
            }];
        } else {
            [self addObject:anObject];
        }
        
    }
}
- (void)kvo_insertObject:(id)anObject atIndex:(NSUInteger)index
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
    NSAssert(index <= self.count, @"make sure index <= self.count be YES");
#endif
    if (anObject
        && index <= self.count) {
        NSArray <VVKVOArrayItem *>*items = [VVKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
            changedModel.changeType = VVKVOArrayChangeTypeAddAtIndex;
            VVKVOArrayElement *element = [VVKVOArrayElement elementWithObject:anObject index:index];
            changedModel.changedElements = @[element];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(VVKVOArrayItem * _Nullable item) {
                [self insertObject:anObject atIndex:index];
                if (item) {
                    [item addObserverOfElement:element];
                }
                return YES;
            }];
        } else {
            [self insertObject:anObject atIndex:index];
        }
    }
}

- (void)kvo_removeLastObject
{
#if DEBUG
    NSAssert(self.count > 0, @"make sure self.count > 0 be YES");
#endif
    if (self.count > 0) {
        NSArray <VVKVOArrayItem *>*items = [VVKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSInteger index = [self count] - 1;
            VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
            changedModel.changeType = VVKVOArrayChangeTypeRemoveTail;
            VVKVOArrayElement *element = [VVKVOArrayElement elementWithObject:self.lastObject index:index];
            changedModel.changedElements = @[element];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(VVKVOArrayItem * _Nullable item) {
                __kindof NSObject *element = self.lastObject;
                if (item) {
                    [item removeObserverOfElement:element];
                }
                [self removeLastObject];
                return YES;
            }];
        } else {
            [self removeLastObject];
        }
    }
}
- (void)kvo_removeObjectAtIndex:(NSUInteger)index
{
#if DEBUG
    NSAssert(index < self.count, @"make sure index < self.count be YES");
#endif
    if (index < self.count) {
        NSArray <VVKVOArrayItem *>*items = [VVKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
            changedModel.changeType = VVKVOArrayChangeTypeRemoveAtIndex;
            VVKVOArrayElement *element = [VVKVOArrayElement elementWithObject:self[index] index:index];
            changedModel.changedElements = @[element];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(VVKVOArrayItem * _Nullable item) {
                __kindof NSObject *element = self[index];
                if (item) {
                    [item removeObserverOfElement:element];
                }
                [self removeObjectAtIndex:index];
                return YES;
            }];
        } else {
            [self removeObjectAtIndex:index];
        }
    }
}

- (void)kvo_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
    NSAssert(index < self.count, @"make sure index < self.count be YES");
#endif
    if (anObject
        && index < self.count
        && ![self[index] isEqual:anObject]) {
        NSArray <VVKVOArrayItem *>*items = [VVKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
            changedModel.changeType = VVKVOArrayChangeTypeReplace;
            VVKVOArrayElement *newElement = [VVKVOArrayElement elementWithObject:anObject index:index];
            changedModel.changedElements = @[newElement];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(VVKVOArrayItem * _Nullable item) {
                [self replaceObjectAtIndex:index withObject:anObject];
                if (item) {
                    [item addObserverOfElement:anObject];
                }
                return YES;
            }];
        } else {
            [self replaceObjectAtIndex:index withObject:anObject];
        }
    }
}

- (void)kvo_addObjectsFromArray:(NSArray<id> *)otherArray
{
#if DEBUG
    NSAssert(otherArray.count > 0, @"make sure otherArray.count > 0 be YES");
#endif
    if (otherArray.count > 0) {
        NSArray <VVKVOArrayItem *>*items = [VVKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSMutableArray *array = [NSMutableArray new];
            for (NSInteger i = 0; i < otherArray.count; i++) {
                NSObject *object = otherArray[i];
                NSInteger index = self.count + i;
                VVKVOArrayElement *element = [VVKVOArrayElement elementWithObject:object index:index];
                [array addObject:element];
            }
            VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
            changedModel.changeType = VVKVOArrayChangeTypeAddTail;
            changedModel.changedElements = [array copy];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(VVKVOArrayItem * _Nullable item) {
                [self addObjectsFromArray:otherArray];
                if (item) {
                    for (VVKVOArrayElement *kvoElement in array) {
                        [item addObserverOfElement:kvoElement.object];
                    }
                }
                return YES;
            }];
        } else {
            [self addObjectsFromArray:otherArray];
        }
    }
}

- (void)kvo_removeAllObjects
{
    if (self.count > 0) {
        NSArray <VVKVOArrayItem *>*items = [VVKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSMutableArray *array = [NSMutableArray new];
            for (NSInteger i = 0; i < self.count; i++) {
                NSObject *object = self[i];
                NSInteger index = i;
                VVKVOArrayElement *element = [VVKVOArrayElement elementWithObject:object index:index];
                [array addObject:element];
            }
            VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
            changedModel.changeType = VVKVOArrayChangeTypeRemoveTail;
            changedModel.changedElements = [array copy];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(VVKVOArrayItem * _Nullable item) {
                if (item) {
                    for (VVKVOArrayElement *kvoElement in array) {
                        [item removeObserverOfElement:kvoElement.object];
                    }
                }
                [self removeAllObjects];
                return YES;
            }];
        } else {
            [self removeAllObjects];
        }
    }
}

- (void)kvo_removeObject:(id)anObject
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
#endif
    if (anObject
        && [self containsObject:anObject]) {
        NSArray <VVKVOArrayItem *>*items = [VVKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSMutableArray *array = [NSMutableArray new];
            for (NSInteger i = 0; i < self.count; i++) {
                NSObject *object = self[i];
                if ([object isEqual:anObject]) {
                    NSInteger index = i;
                    VVKVOArrayElement *element = [VVKVOArrayElement elementWithObject:object index:index];
                    [array addObject:element];
                }
            }
            VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
            changedModel.changeType = VVKVOArrayChangeTypeRemoveAtIndex;
            changedModel.changedElements = [array copy];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(VVKVOArrayItem * _Nullable item) {
                if (item) {
                    for (VVKVOArrayElement *kvoElement in array) {
                        [item removeObserverOfElement:kvoElement.object];
                    }
                }
                [self removeObject:anObject];
                return YES;
            }];
        } else {
            [self removeObject:anObject];
        }
    }
}

- (void)invokeChangeWithItems:(NSArray<VVKVOArrayItem *>*)items
                 changedModel:(VVKVOArrayChangeModel *)changedModel
                  actionBlock:(BOOL(^)(VVKVOArrayItem * _Nullable item))actionBlock
{
    NSMutableArray *old_self = nil;
    BOOL hasAddedElement = NO;
    for (VVKVOArrayItem *item in items) {
        if (!old_self) {
            if ((item.options & NSKeyValueObservingOptionOld) == NSKeyValueObservingOptionOld) {
                old_self = [self mutableCopy];
            }
        } else {
            break;
        }
    }
    for (VVKVOArrayItem *item in items) {
        if (!item.detailBlock) {
            if (actionBlock) {
                actionBlock(nil);
            }
            return;
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ((item.options & NSKeyValueObservingOptionOld) == NSKeyValueObservingOptionOld) {
            dic[NSKeyValueChangeOldKey] = old_self;
        }
        if (!hasAddedElement) {
            if (actionBlock) {
                hasAddedElement = actionBlock(item);
            }
        }
        if ((item.options & NSKeyValueObservingOptionNew) == NSKeyValueObservingOptionNew) {
            dic[NSKeyValueChangeNewKey] = self;
        }
        item.detailBlock(item.keyPath, dic, changedModel, item.context);
    }
    
}
@end
