//
//  NSArray+DataProtect.h
//  VVRootLib
//
//  Created by JackLee on 2019/8/14.
//  Copyright © 2019 com.lebby.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGeometry.h>
#import <CoreGraphics/CGBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (DataProtect)

- (nullable ObjectType)vv_objectWithIndex:(NSInteger)index;

/// 根据索引获取元素，并对元素类型进行判定，如果符合正常返回，不符合则返回nil
/// @param index 索引
/// @param theClass 指定的类型
- (nullable ObjectType)vv_objectWithIndex:(NSInteger)index
                      verifyClass:(nullable Class)theClass;

- (nullable NSString *)vv_stringWithIndex:(NSInteger)index;

- (nullable NSNumber *)vv_numberWithIndex:(NSInteger)index;

- (nullable NSDecimalNumber *)vv_decimalNumberWithIndex:(NSInteger)index;

- (nullable NSArray <ObjectType>*)vv_arrayWithIndex:(NSInteger)index;

- (nullable NSDictionary *)vv_dictionaryWithIndex:(NSInteger)index;

- (NSInteger)vv_integerWithIndex:(NSInteger)index;

- (NSUInteger)vv_unsignedIntegerWithIndex:(NSInteger)index;

- (BOOL)vv_boolWithIndex:(NSInteger)index;

- (int16_t)vv_int16WithIndex:(NSInteger)index;

- (int32_t)vv_int32WithIndex:(NSInteger)index;

- (int64_t)vv_int64WithIndex:(NSInteger)index;

- (char)vv_charWithIndex:(NSInteger)index;

- (short)vv_shortWithIndex:(NSInteger)index;

- (float)vv_floatWithIndex:(NSInteger)index;

- (CGFloat)vv_cgFloatWithIndex:(NSInteger)index;

- (double)vv_doubleWithIndex:(NSInteger)index;

- (nullable NSDate *)vv_dateWithIndex:(NSInteger)index
                  dateFormat:(nonnull NSString *)dateFormat;

/**
 /// 获取数组元素中key对应的value的集合组成的数据，返回的数组内的元素是可以相同的
 @param key key
 @return key对应的value组成的数组
 */
- (nullable NSMutableArray *)vv_valueArrayWithKey:(nonnull NSString *)key;

/// 获取数组元素中key对应的value的集合组成的数据，返回的数组内的元素是不相同
/// @param key key
- (NSArray <ObjectType>*)vv_uniqueValuesWithKey:(nonnull NSString *)key;

- (CGPoint)vv_pointWithIndex:(NSInteger)index;

- (CGSize)vv_sizeWithIndex:(NSInteger)index;

- (CGRect)vv_rectWithIndex:(NSInteger)index;

/**
 升序 数组元素为纯数字的NSString类型，或者NSNumber类型
 
 @return 排序后的数组
 */
- (nonnull NSMutableArray <ObjectType>*)vv_ascSort;

/**
 降序 数组元素为纯数字的NSString类型，或者NSNumber类型
 
 @return 排序后的数组
 */
- (nonnull NSMutableArray <ObjectType>*)vv_descSort;


@end

NS_ASSUME_NONNULL_END
