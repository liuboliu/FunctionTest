//
//  VVUIMacros.h
//  Airydress
//
//  Created by Yongjian Ling on 25/10/17.
//  Copyright © 2017年 Airydress. All rights reserved.
//


#ifndef VVUIMacros_h
#define VVUIMacros_h


//main window
#define kMainWindow                [UIApplication sharedApplication].keyWindow

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

//iphone  X系列判断

// RGB颜色
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

// 根据屏幕的宽度自适应，此处UISize如同fontSize，不是结构体CGSize
#define autoScaleSize(UISize) (UISize * SCREEN_W / 375)// 375为设计图宽度

//商品列表 商品cell 之间的itemspace
#define Item_space 10
//商品列表 商品cell 的宽度
#define WidthOfProductCell  ([UIScreen mainScreen].bounds.size.width - 3 * Item_space) / 2
//商品列表 商品cell 的高度
#define HeightOfProductCell  ([UIScreen mainScreen].bounds.size.width - 3 * Item_space) / 2

// 判断反向布局
#define IS_RightToLeft \
({BOOL isRightToLeft = NO;\
if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {\
	isRightToLeft = YES;\
}\
(isRightToLeft);})\

//判断暗黑模式
#define IS_DarkMode \
({BOOL isDarkMode = NO;\
if (@available(iOS 13.0, *)) {\
	   if ([UIScreen mainScreen].traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {\
		   isDarkMode = YES;\
	   }\
   }\
(isDarkMode);})\

#endif /* VVUIMacros_h */
