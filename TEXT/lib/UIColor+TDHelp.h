//
//  UIColor+Helpers.h
//  mobile
//
//  Created by Demi on 6/28/16.
//  Copyright © 2016 azazie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TDHelp)

/**
 十六进制颜色转UIColor

 @param hex 十六进制颜色
 @return 颜色
 */
+ (instancetype)colorWithHex:(NSUInteger)hex;

/**
 十六进制颜色转UIColor
 
 @param hex 十六进制颜色
 @param alpha 透明度
 @return 颜色
 */
+ (instancetype)colorWithHex:(NSUInteger)hex
                       alpha:(CGFloat)alpha;

/**
 十六进制颜色转UIColor

 @param css 十六进制颜色
 @return 颜色
 */
+ (instancetype)colorWithCSS:(NSString *)css;

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 获取颜色的十六进制值

 @return 十六进制值
 */
- (NSUInteger)hex;

/**
 获取颜色的十六进制值
 
 @return 十六进制值
 */
- (NSString *)hexString;

/**
 获取颜色的十六进制值
 
 @return 十六进制值
 */
- (NSString *)cssString;

/**
 获取随机色

 @return 随机色
 */
+ (instancetype)randomColor;

/**
 获取两个颜色的中间色

 @param beginColor 起始色
 @param endColor 结束色
 @param percent 起始色和结束色的比例
 @return 两个颜色的中间色
 */
+ (instancetype)colorWithBeginColor:(UIColor *)beginColor
                           endColor:(UIColor *)endColor
                            percent:(CGFloat)percent;

/// 是否暖色系颜色
- (BOOL)vv_isDarkColor;

@end
