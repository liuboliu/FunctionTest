//
//  NSMutableArray+VVKVOHelper.h
//  kvo_rootlib_ios
//
//  Created by JackLee on 2020/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (VVKVOHelper)

- (void)kvo_addObject:(id)anObject;
- (void)kvo_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)kvo_removeLastObject;
- (void)kvo_removeObjectAtIndex:(NSUInteger)index;
- (void)kvo_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (void)kvo_addObjectsFromArray:(NSArray<id> *)otherArray;
- (void)kvo_removeAllObjects;
- (void)kvo_removeObject:(id)anObject;

@end

NS_ASSUME_NONNULL_END
