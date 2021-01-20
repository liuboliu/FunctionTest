//
//  NSObject+Swizzle.h
//  FloryDay
//
//  Created by chuxiao on 2018/5/21.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Swizzle)

/**
 实例方法交换
 
 @param fdClass 被交换的class
 @param originalSel 源方法
 @param swizzledSel 交换方法
 */
+ (void)exchangeInstanceMethod:(Class _Nonnull)fdClass
                   originalSel:(SEL _Nonnull)originalSel
                   swizzledSel:(SEL _Nonnull)swizzledSel;


/**
 类方法替换
 
 @param fdClass class
 @param originalSel 源方法
 @param swizzledSel 替换方法
 */
+ (void)exchangeClassMethod:(Class _Nonnull )fdClass
                originalSel:(SEL _Nonnull )originalSel
                swizzledSel:(SEL _Nonnull )swizzledSel;

@end
