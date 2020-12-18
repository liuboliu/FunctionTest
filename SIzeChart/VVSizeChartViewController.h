//
//  VVSizeChartViewController.h
//  Vova
//
//  Created by Dwayne on 2018/8/14.
//  Copyright © 2018年 iOS. All rights reserved.
//
typedef NS_ENUM(NSInteger, VVSizeChartSourceType) {
    VVSizeChartSourceTypeDefault = 0,
    VVSizeChartSourceTypeNoneAddToCartBtn,// 不展示加车按钮
};

#import "BaseViewController.h"
#import "VVProductDetailModel.h"

@class VVSizeListModel;
@class VVStandardSizeListModel;

@interface VVSizeChartViewControllerConfiguration : NSObject

@property (nonatomic, assign) VVProductDetailViewType detailType;

@property (nonatomic, assign) BOOL reminded;

//商品尺码列表
@property (nonatomic, strong) NSArray <VVSizeListModel *> *sizeArray;
//商品标准码对应表
@property (nonatomic, strong) NSArray <VVStandardSizeGenderModel *> *standardSizeArray;
//保存了标准尺码表头部的一行标题的数组
@property (nonatomic, strong) NSArray <NSString *> *keyArray;
//二维数组，其中的每个小数组是保存了一行的CM 数据
@property (nonatomic, strong) NSArray <NSArray *> *cmSizeArray;
//二维数组其中的每个小数组保存了一行需要展示的inch 数据
@property (nonatomic, strong) NSArray <NSArray *> *inchSizeArray;
//TIP
@property (nonatomic, copy) NSString *tips;

@property (nonatomic, assign) BOOL isOutOfStock; //是否下架
@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, copy) NSString *skuDialogBuyText;
@property (nonatomic, strong) UIColor *bottomTextColor;//底部按钮颜色
@property (nonatomic, copy) void (^addCart)(void); //添加购物车回调
@property (nonatomic, copy) void (^close)(void); //取消回调
@property (nonatomic, assign) VVSizeChartSourceType sourceType;
//@property (copy, nonatomic)  VVProductFreeSaleInfo *free_sale;
/*
 在加车弹层中弹出sizechart，
 为了sizechart消失之后再次present出来原来的加车弹层，
 对加车弹层强持有一次，防止加车弹层被释放
 */
@property (nonatomic, strong) UIViewController *addToCartVC;

@end

typedef void(^SizeChartClickAction)(void);

@interface VVSizeChartViewController : BaseViewController

@property (nonatomic, strong) UIColor *themeColor;
@property (nonatomic, strong) NSString *skuDialogBuyText;

- (instancetype)initWithConfiguration:(VVSizeChartViewControllerConfiguration *)configuration;

- (void)setUpConfirmButton;

@end
