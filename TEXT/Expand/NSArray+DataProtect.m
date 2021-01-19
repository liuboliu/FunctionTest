//
//  NSArray+DataProtect.m
//  VVRootLib
//
//  Created by JackLee on 2019/8/14.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import "NSArray+DataProtect.h"

@implementation NSArray (DataProtect)

- (nullable id)vv_objectWithIndex:(NSInteger)index
{
    if (index < 0) {
        return nil;
    }
    if (index < self.count) {
        return self[index];
    }
    return nil;
}

- (nullable id)vv_objectWithIndex:(NSInteger)index
                      verifyClass:(nullable Class)theClass
{
    if (!theClass) {
        return [self vv_objectWithIndex:index];
    }
 if (![theClass isSubclassOfClass:[NSObject class]]) {
#if DEBUG
        NSAssert(NO, @"theClass must be subClass of NSObject");
#endif
        return nil;
    }
    id object = [self vv_objectWithIndex:index];
    if ([object isKindOfClass: theClass]) {
        return object;
    }
    return nil;
}

- (nullable NSString*)vv_stringWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

- (nullable NSNumber*)vv_numberWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (nullable NSDecimalNumber *)vv_decimalNumberWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (nullable NSArray*)vv_arrayWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (nullable NSDictionary *)vv_dictionaryWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)vv_integerWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)vv_unsignedIntegerWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)vv_boolWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)vv_int16WithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)vv_int32WithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)vv_int64WithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)vv_charWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)vv_shortWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}

- (float)vv_floatWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (CGFloat)vv_cgFloatWithIndex:(NSInteger)index
{
    CGFloat value = (CGFloat)[self vv_floatWithIndex:index];
    return value;
}

- (double)vv_doubleWithIndex:(NSInteger)index
{
    id value = [self vv_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (nullable NSDate *)vv_dateWithIndex:(NSInteger)index
                           dateFormat:(nonnull NSString *)dateFormat
{
    id value = [self vv_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        NSDateFormatter *formater = [[NSDateFormatter alloc]init];
        formater.dateFormat = dateFormat;
        return [formater dateFromString:value];
    }
    return nil;
}

- (nullable NSMutableArray *)vv_valueArrayWithKey:(nonnull NSString *)key
{
    if (!key) {
#if DEBUG
        NSAssert(NO, @"key can not be nil");
#endif
        return nil;
    }
    NSMutableArray *values = [NSMutableArray new];
    for (NSObject *obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            id value = [dic objectForKey:key];
            if (value) {
                [values addObject:value];
            }
        } else {
            SEL selector = NSSelectorFromString(key);
            if ([obj respondsToSelector:selector]) {
                id value = [obj valueForKey:key];
                if (value) {
                    [values addObject:value];
                }
            }
        }
    }
    return values;
}

- (NSArray *)vv_uniqueValuesWithKey:(nonnull NSString *)key
{
    if (!key) {
#if DEBUG
        NSAssert(NO, @"key can't be nil");
#endif
        return nil;
    }
    NSMutableSet *set = [NSMutableSet new];
    for (NSObject *obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            id value = [dic objectForKey:key];
            if (value) {
                [set addObject:value];
            }
        } else {
            SEL selector = NSSelectorFromString(key);
            if ([obj respondsToSelector:selector]) {
                id value = [obj valueForKey:key];
                if (value) {
                    [set addObject:value];
                }
            }
        }
        
    }
    return [set allObjects];
}

- (CGPoint)vv_pointWithIndex:(NSInteger)index
{
    id value = [self vv_stringWithIndex:index];
    CGPoint point = CGPointFromString(value);
    return point;
}

- (CGSize)vv_sizeWithIndex:(NSInteger)index
{
    id value = [self vv_stringWithIndex:index];
    CGSize size = CGSizeFromString(value);
    return size;
}

- (CGRect)vv_rectWithIndex:(NSInteger)index
{
    id value = [self vv_stringWithIndex:index];
    CGRect rect = CGRectFromString(value);
    return rect;
}

- (nonnull NSMutableArray *)vv_ascSort
{
    NSMutableArray *array = (NSMutableArray *)self;
    if (![self isKindOfClass:[NSMutableArray class]]) {
        array = [NSMutableArray arrayWithArray:self];
    }
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 integerValue] > [obj2 integerValue];
    }];
    return array;
}

- (nonnull NSMutableArray *)vv_descSort
{
    NSMutableArray *array = (NSMutableArray *)self;
    if (![self isKindOfClass:[NSMutableArray class]]) {
        array = [NSMutableArray arrayWithArray:self];
    }
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 integerValue] < [obj2 integerValue];
    }];
    return array;
}

@end
